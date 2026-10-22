/* JOB_fnc_init (postInit) : module métiers (serveur + client) */
// Objets nommés dans l'éditeur dont le nom commence par "job_" (bureaux, bornes, caisses...) : ce sont des points de travail
JOB_objs = (allVariables missionNamespace) select {
    (_x find "job_") == 0 && {(_x find "job_fnc_") != 0} && {(missionNamespace getVariable _x) isEqualType objNull} && {!isNull (missionNamespace getVariable _x)}
};
diag_log format ["[JOB] %1 objet(s) de travail trouvé(s) : %2", count JOB_objs, JOB_objs];
if (isServer) then {
    [missionNamespace, "CORE_playerLoaded", { _this call JOB_fnc_srvOnLoaded; }] call BIS_fnc_addScriptedEventHandler;

    // Contrat : chaque minute EN SERVICE (avec une tâche terminée récemment) compte pour le contrat minimum
    [] spawn {
        private _cfg = missionConfigFile >> "JOB_Settings";
        while { true } do {
            sleep 60;
            private _afk = 60 * getNumber (_cfg >> "afkMinutes");
            private _min = 60 * getNumber (_cfg >> "minContractMinutes");
            {
                private _u = _x;
                if ((_u getVariable ["JOB_duty", false]) && {_u getVariable ["CORE_active", false]} && {time - (_u getVariable ["JOB_lastTask", -1e6]) < _afk}) then {
                    private _c = [_u, "job_contract", 0] call CORE_fnc_getValue;
                    [_u, "job_contract", _c + 60] call CORE_fnc_setValue;
                    if (_c < _min && {_c + 60 >= _min}) then {
                        ["[Travail] Contrat minimum effectué : vous pouvez désormais démissionner au Pôle Emploi si vous le souhaitez."] remoteExec ["CORE_fnc_clientMsg", _u];
                    };
                    [_u] call JOB_fnc_srvSync;
                };
            } forEach allPlayers;
        };
    };
    // Objets de travail (caisses, bureaux...) : inventaire verrouillé, les pièces et pompes passent uniquement par le métier
    { private _o = missionNamespace getVariable [_x, objNull]; if (!isNull _o) then { _o lockInventory true; }; } forEach JOB_objs;
    JOB_pumpStock = 0;
    // Véhicules de service : réservés à leur propriétaire, épaves rangées au bout de 2 min, rangés à la déconnexion
    JOB_vehs = [];
    [] spawn {
        while { true } do {
            sleep 2;
            {
                private _v = _x;
                if (!alive _v) then {
                    if (isNil { _v getVariable "JOB_deadAt" }) then { _v setVariable ["JOB_deadAt", time]; };
                    if (time - (_v getVariable ["JOB_deadAt", time]) > 120) then { deleteVehicle _v; };
                } else {
                    private _uid = _v getVariable ["JOB_owner", ""];
                    {
                        if (isPlayer _x && {getPlayerUID _x != _uid}) then {
                            [_v] remoteExec ["JOB_fnc_clientEject", _x];
                            [format ["[Travail] Ce véhicule de service est réservé à %1.", _v getVariable ["JOB_ownerName", "un employé"]]] remoteExec ["CORE_fnc_clientMsg", _x];
                        };
                    } forEach crew _v;
                };
            } forEach JOB_vehs;
            JOB_vehs = JOB_vehs select { !isNull _x };
        };
    };
    addMissionEventHandler ["HandleDisconnect", { params ["_unit"]; [_unit] call JOB_fnc_srvVehClear; false }];
    diag_log "[JOB] module métiers initialisé sur le serveur";
};

if (!hasInterface) exitWith {};
JOB_busy = false;
JOB_tgt = [];
JOB_route = [];
JOB_rMk = [];
JOB_rpts = [];
JOB_rK = 0;
private _r = getNumber (missionConfigFile >> "JOB_Settings" >> "pointRadius");

// --- Pôle Emploi : marqueurs job_pole_* et bâtiments listés dans poleClasses ---
["job_pole", "Pôle Emploi", "job_pole", _r + 2] call INT_fnc_registerPoint;
["job_pole_open", "Pôle Emploi", "point:job_pole", { true }, { [] spawn JOB_fnc_poleOpen; }, 20] call INT_fnc_registerAction;
["job_pole_obj", "Pôle Emploi", "object",
    { params ["_o"]; private _t = toLower typeOf _o;
      ((toLower vehicleVarName _o) find "job_pole") == 0 || {((getArray (missionConfigFile >> "JOB_Settings" >> "poleClasses")) findIf { (_t find (toLower _x)) == 0 }) != -1} },
    { [] spawn JOB_fnc_poleOpen; }, 20] call INT_fnc_registerAction;

// --- Lieux de travail (prise de service) et points d'étapes, pour chaque métier ---
private _stepTypes = [];
{
    private _id = configName _x;
    private _svc = format ["job_%1_service", _id];
    [_svc, "Lieu de travail", _svc, _r] call INT_fnc_registerPoint;
    [_svc, { if ((player getVariable ["JOB_state", []]) param [8, false]) then { "Terminer mon service" } else { "Prendre mon service" } }, format ["point:%1", _svc],
        { params ["_m"]; private _s = player getVariable ["JOB_state", []]; count _s > 0 && {(_s select 0) != ""} && {(_m find format ["job_%1_service", _s select 0]) == 0} },
        { params ["_m"]; [player, _m] remoteExec ["JOB_fnc_srvDuty", 2]; }, 21] call INT_fnc_registerAction;
    {
        {
            _stepTypes pushBackUnique (_x select 0);
            if ((_x param [6, ""]) == "qcDrop") then { _stepTypes pushBackUnique "job_usine_expedition"; _stepTypes pushBackUnique "job_usine_rebut"; };
        } forEach getArray (_x >> "steps");
    } forEach ("true" configClasses (_x >> "Levels"));
} forEach ("true" configClasses (missionConfigFile >> "JOB_Jobs"));

{
    [_x, "Travail", _x, _r] call INT_fnc_registerPoint;
    [format ["job_step_%1", _x], { (player getVariable ["JOB_state", []]) param [6, "Travailler"] }, format ["point:%1", _x],
        { params ["_m"];
          private _s = player getVariable ["JOB_state", []];
          count _s > 0 && {_s select 8} && {(_s select 13) != ""} && {(_s param [18, ""]) != "veh"} && {(_m find (_s select 13)) == 0} && {(_s select 7) == "" || {(_s select 7) == _m}} },
        { params ["_m"]; [_m] spawn JOB_fnc_doStep; }, 5] call INT_fnc_registerAction;
} forEach _stepTypes;

// --- Mêmes actions sur des OBJETS nommés dans l'éditeur (bureau, borne, pointeuse, caisse de pièces, compteur...) ---
["job_svc_obj", { if ((player getVariable ["JOB_state", []]) param [8, false]) then { "Terminer mon service" } else { "Prendre mon service" } }, "object",
    { params ["_o"]; private _s = player getVariable ["JOB_state", []];
      count _s > 0 && {(_s select 0) != ""} && {((toLower vehicleVarName _o) find format ["job_%1_service", _s select 0]) == 0} },
    { params ["_o"]; [player, toLower vehicleVarName _o] remoteExec ["JOB_fnc_srvDuty", 2]; }, 21] call INT_fnc_registerAction;
["job_step_obj", { (player getVariable ["JOB_state", []]) param [6, "Travailler"] }, "object",
    { params ["_o"];
      private _n = toLower vehicleVarName _o;
      private _s = player getVariable ["JOB_state", []];
      _n != "" && {count _s > 0} && {_s select 8} && {(_s select 13) != ""} && {(_s param [18, ""]) != "veh"} && {(_n find toLower (_s select 13)) == 0} && {(_s select 7) == "" || {toLower (_s select 7) == _n}} },
    { params ["_o"]; [toLower vehicleVarName _o] spawn JOB_fnc_doStep; }, 5] call INT_fnc_registerAction;

// --- Application « Emploi » du téléphone ---
["job", "Emploi", [0.95, 0.55, 0.12, 1], "E", JOB_fnc_pgPhone, "", false] call PHN_fnc_registerApp;

// --- Repère de la tâche en cours (carte + écran) ---
[] spawn JOB_fnc_targetLoop;
addMissionEventHandler ["Draw3D", {
    if (JOB_tgt isEqualTo []) exitWith {};
    JOB_tgt params ["_p", "_t"];
    drawIcon3D ["", [1, 0.75, 0.15, 1], _p, 0, 0, 0, format ["%1 (%2 m)", _t, round (player distance2D _p)], 1, 0.032, "PuristaMedium", "center", false];
}];
// Marqueur local du joueur (flèche blanche, utilisé par le GPS)
createMarkerLocal ["JOB_me", [0, 0, 0]];
"JOB_me" setMarkerTypeLocal "mil_arrow2";
"JOB_me" setMarkerColorLocal "ColorWhite";
"JOB_me" setMarkerSizeLocal [0.8, 0.8];
"JOB_me" setMarkerAlphaLocal 0;
