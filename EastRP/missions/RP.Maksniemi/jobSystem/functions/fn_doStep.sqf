/* CLIENT : effectuer l'étape en cours sur un point (rester sur place pendant la durée), puis demander la validation au serveur.
   Étapes « veh » : à faire au volant du véhicule de service. Étapes « quiz:... » : mini-jeu de diagnostic à la fin.
   params: [point]. À lancer avec spawn. */
params ["_m"];
if (JOB_busy) exitWith {};
private _s = player getVariable ["JOB_state", []];
if (count _s == 0) exitWith {};
JOB_busy = true;
private _cfgS = missionConfigFile >> "JOB_Settings";
private _dur = (_s select 14) max 1;
private _label = _s select 6;
private _sp = _s param [18, ""];
private _inVeh = _sp == "veh";
private _r = if (_inVeh) then { getNumber (_cfgS >> "vehRadius") + 2 } else { getNumber (_cfgS >> "pointRadius") + 2 };
private _ok = true;
private _lv = [_s select 0, _s select 3] call JOB_fnc_cfgLevel;
private _step = (getArray ((_lv select 1) >> "steps")) param [_s select 5, []];
// Objet requis pour l'étape (pièce, pompe...) : vérifié avant de commencer
private _need = _step param [7, ""];
if (_need != "" && {!(_need in magazines player)}) exitWith {
    JOB_busy = false;
    systemChat format ["[Travail] Il vous faut : %1 (voir l'étape précédente).", getText (configFile >> "CfgMagazines" >> _need >> "displayName")];
};
private _anim = "";
if (!_inVeh) then {
    player setDir (player getDir ([_m] call JOB_fnc_pointPos));   // face au point de travail
    // Animation de l'étape (5e élément de l'étape dans JOB_Jobs), sinon animation générique
    _anim = _step param [4, ""];
    if (_anim != "" && {isClass (configFile >> "CfgMovesMaleSdr" >> "States" >> _anim)}) then {
        player switchMove _anim;                              // effet immédiat pour soi
        [player, _anim] remoteExec ["JOB_fnc_srvAnim", 2];    // le serveur la diffuse aux autres joueurs
    } else {
        _anim = "";
        player playActionNow "Medic";
    };
};
// Objets en main (carnet, crayon...) : 6e élément de l'étape = [[classe, os, décalage, apparition s, disparition s], ...]
JOB_propObjs = [];
private _props = _step param [5, []];
if (_anim != "" && {_props isEqualType []}) then {
    {
        _x params [["_cls", ""], ["_bone", "righthand"], ["_off", [0, 0, 0]], ["_t0", 0], ["_t1", 1e9]];
        if (isClass (configFile >> "CfgVehicles" >> _cls)) then {
            [_cls, _bone, _off, _t0, _t1] spawn {
                params ["_cls", "_bone", "_off", "_t0", "_t1"];
                private _st = time;
                waitUntil { sleep 0.1; (time - _st >= _t0) || {!JOB_busy} };
                if (!JOB_busy) exitWith {};
                private _o = createVehicle [_cls, [0, 0, 0], [], 0, "CAN_COLLIDE"];
                _o attachTo [player, _off, _bone, true];
                JOB_propObjs pushBack _o;
                waitUntil { sleep 0.1; (time - _st >= _t1) || {!JOB_busy} };
                deleteVehicle _o;
            };
        } else {
            diag_log format ["[JOB] objet de travail introuvable : %1", _cls];
        };
    } forEach _props;
};
for "_i" from _dur to 1 step -1 do {
    hintSilent format ["%1...\n%2 s", _label, _i];
    sleep 1;
    if (!alive player || {([player, _m] call JOB_fnc_pointDist) > _r} || {if (_inVeh) then { vehicle player == player } else { vehicle player != player }}) exitWith { _ok = false; };
};
hintSilent "";
if (_anim != "") then {
    // Fin : à genoux puis debout (pour soi), et pareil chez les autres joueurs
    if (alive player && {(toLower animationState player) find "eastrp_" == 0}) then {
        player switchMove "AmovPknlMstpSnonWnonDnon";
        player playMoveNow "AmovPercMstpSnonWnonDnon";
    };
    [player, ""] remoteExec ["JOB_fnc_srvAnim", 2];
};
private _ans = -1;
private _quizCancel = false;
if (_ok && {(_sp find "quiz:") == 0}) then {
    _ans = [_label, _s param [19, []]] call JOB_fnc_quizAsk;
    if (_ans < 0) then { _ok = false; _quizCancel = true; };
};
if (_ok) then {
    [player, _m, _ans] remoteExec ["JOB_fnc_srvStep", 2];
} else {
    if (_quizCancel) then {
        systemChat "[Travail] Analyse annulée : recommencez l'étape.";
    } else {
        systemChat (if (_inVeh) then { "[Travail] Action interrompue : restez au point, au volant de votre véhicule de service." } else { "[Travail] Action interrompue : restez sur place jusqu'à la fin." });
    };
};
JOB_busy = false;
{ deleteVehicle _x } forEach JOB_propObjs;   // sécurité : plus aucun objet en main
