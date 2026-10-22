/* SERVEUR : le joueur a terminé l'étape en cours sur un point de travail. Le serveur re-vérifie tout, puis paie à la fin de la tâche.
   params: [unit, point, réponse au mini-jeu (-1 si pas de mini-jeu)] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_mk", "", [""]], ["_ans", -1, [0]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit} || {!alive _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
private _msg = { params ["_m"]; [_m] remoteExec ["CORE_fnc_clientMsg", _unit]; };
private _cfg = missionConfigFile >> "JOB_Settings";
private _job = [_unit, "job", ""] call CORE_fnc_getValue;
if (_job == "" || {!(_unit getVariable ["JOB_duty", false])}) exitWith { ["[Travail] Vous n'êtes pas en service."] call _msg; };

private _xp = [_unit, _job] call JOB_fnc_getXp;
(([_job, _xp] call JOB_fnc_cfgLevel)) params ["_n", "_lc"];
private _steps = getArray (_lc >> "steps");
if (_steps isEqualTo []) exitWith {};
private _idx = (_unit getVariable ["JOB_step", 0]) min (count _steps - 1);
(_steps select _idx) params ["_type", "_label", "_dur"];
private _sp = (_steps select _idx) param [6, ""];
private _ov = _unit getVariable ["JOB_stepOverride", []];
if (count _ov == 2) then { _type = _ov select 0; };
if ((toLower _mk find toLower _type) != 0) exitWith { ["[Travail] Ce n'est pas la bonne étape."] call _msg; [_unit] call JOB_fnc_srvSync; };
private _as = _unit getVariable ["JOB_assigned", ""];
if (_as != "" && {toLower _mk != toLower _as}) exitWith { ["[Travail] Ce n'est pas le point indiqué : suivez le repère."] call _msg; };
// Objet requis pour cette étape (pièce, pompe...) : sinon on reprend la tâche depuis le début
private _need = (_steps select _idx) param [7, ""];
private _give = (_steps select _idx) param [8, ""];
if (_need != "" && {!(_need in magazines _unit)}) exitWith {
    [format ["[Travail] Il vous faut : %1. La tâche reprend depuis le début.", getText (configFile >> "CfgMagazines" >> _need >> "displayName")]] call _msg;
    _unit setVariable ["JOB_step", 0];
    [_unit] call JOB_fnc_srvAssign;
    [_unit] call JOB_fnc_srvSync;
};
private _rad = if (_sp == "veh") then { getNumber (_cfg >> "vehRadius") } else { getNumber (_cfg >> "pointRadius") };
if (([_unit, _mk] call JOB_fnc_pointDist) > _rad + 3) exitWith { ["[Travail] Vous êtes trop loin."] call _msg; };
if (time - (_unit getVariable ["JOB_stepT", 0]) < ((_dur max 1) - 0.5)) exitWith { [format ["[JOB] étape trop rapide refusée pour %1", name _unit]] call JOB_fnc_dbg; };
if (_sp == "veh") then {
    private _v = _unit getVariable ["JOB_veh", objNull];
    if (!alive _v || {vehicle _unit != _v}) exitWith { _sp = "#refus"; };
};
if (_sp == "#refus") exitWith { ["[Travail] Cette étape se fait au volant de votre véhicule de service."] call _msg; };

// Étape « sortir le véhicule de service »
if (_sp == "vehget") then {
    if !([_unit, _mk, _lc] call JOB_fnc_srvVehSpawn) exitWith { _sp = "#refus2"; };
    [format ["[Travail] Votre %1 vous attend sur le parking. Il est réservé à votre usage pendant votre service.", getText (configFile >> "CfgVehicles" >> typeOf (_unit getVariable ["JOB_veh", objNull]) >> "displayName")]] call _msg;
};
if (_sp == "#refus2") exitWith { ["[Travail] Aucune place libre pour sortir le véhicule : libérez le parking et réessayez."] call _msg; };

// Mini-jeu : bonne ou mauvaise réponse
if ((_sp find "quiz:") == 0 && {count (_unit getVariable ["JOB_quizQ", []]) > 0}) then {
    private _q = _unit getVariable ["JOB_quizQ", []];
    private _good = _unit getVariable ["JOB_quizOk", -1];
    if (_ans == _good) then {
        ["[Travail] Bonne analyse !"] call _msg;
    } else {
        _unit setVariable ["JOB_penalty", true];
        [format ["[Travail] Mauvaise analyse. La bonne réponse était : %1. Salaire de cette tâche réduit.", (_q select 1) param [_good, "?"]]] call _msg;
    };
};

// Caisse de pompes de l'usine (partagée sur le serveur)
if (isNil "JOB_pumpStock") then { JOB_pumpStock = 0; };
if (_sp == "pumpIn") then {
    JOB_pumpStock = (JOB_pumpStock + 1) min getNumber (_cfg >> "pumpStockMax");
    [format ["[Travail] Pompe rangée dans la caisse : %1 pompe(s) en attente de contrôle.", JOB_pumpStock]] call _msg;
};
if (_sp == "pumpOut") then {
    if (JOB_pumpStock > 0) then {
        JOB_pumpStock = JOB_pumpStock - 1;
        [format ["[Travail] Pompe de la production prise dans la caisse (%1 restante(s)).", JOB_pumpStock]] call _msg;
    } else {
        ["[Travail] Caisse vide : pompe de réserve fournie par l'usine."] call _msg;
    };
};
if (_sp == "quiz:fiche") then {
    _unit setVariable ["JOB_qcDecision", [0, 1] select (_ans == 1)];
    [["[Travail] Pompe validée : déposez-la dans la caisse d'expédition.", "[Travail] Pompe refusée : jetez-la dans la benne à rebut."] select (_ans == 1)] call _msg;
};
if (_sp == "qcDrop") then {
    [["[Travail] Pompe déposée dans la caisse d'expédition.", "[Travail] Pompe jetée dans la benne à rebut."] select ((_unit getVariable ["JOB_qcDecision", 0]) == 1)] call _msg;
};
// Échange des objets : on reprend l'objet requis, on donne l'objet de l'étape
if (_need != "" && {_sp != "quiz:fiche"}) then { ["remove", _need] remoteExec ["JOB_fnc_clientItem", _unit]; };   // la pompe contrôlée reste en main jusqu'au dépôt
if (_give != "") then { ["add", _give] remoteExec ["JOB_fnc_clientItem", _unit]; };

_unit setVariable ["JOB_stepT", time];
_unit setVariable ["JOB_lastTask", time];
_unit setVariable ["JOB_lastMarker", _mk];
_idx = _idx + 1;
if (_idx < count _steps) then {
    _unit setVariable ["JOB_step", _idx];
    [_unit] call JOB_fnc_srvAssign;
    private _nidx = _unit getVariable ["JOB_step", _idx];
    [format ["[Travail] Étape suivante : %1.", (_steps select _nidx) select 1]] call _msg;
} else {
    // Tâche complète : salaire + expérience
    private _pay = getNumber (_lc >> "pay");
    private _gain = getNumber (_lc >> "xpPerTask");
    private _extra = "";
    if (_unit getVariable ["JOB_penalty", false]) then {
        _pay = round (_pay * getNumber (_cfg >> "quizPenalty"));
        _gain = round (_gain * getNumber (_cfg >> "quizPenalty"));
        _unit setVariable ["JOB_penalty", false];
    };
    private _tb = getNumber (_lc >> "teamBonus");
    if (_tb > 0) then {
        private _mates = { _x != _unit && {_x getVariable ["JOB_duty", false]} && {([_x, "job", ""] call CORE_fnc_getValue) == _job} && {_x distance _unit < 150} } count allPlayers;
        _mates = _mates min 3;
        if (_mates > 0) then {
            _pay = round (_pay * (1 + _tb * _mates));
            _extra = format [" (prime d'équipe : %1 collègue(s))", _mates];
        };
    };
    private _sym = getText (missionConfigFile >> "CORE_Settings" >> "currencySymbol");
    private _jc = missionConfigFile >> "JOB_Jobs" >> _job;
    if (_pay > 0) then {
        [_unit, "bank", _pay] call CORE_fnc_changeMoney;
        if (!isNil "PHN_fnc_srvLog") then { [_unit, format ["Salaire (%1)", getText (_jc >> "short")], _pay] call PHN_fnc_srvLog; };
    };
    private _arr = +([_unit, "job_xp", []] call CORE_fnc_getValue);
    if !(_arr isEqualType []) then { _arr = []; };
    private _i = _arr findIf { _x isEqualType [] && {(_x select 0) == _job} };
    if (_i < 0) then { _arr pushBack [_job, _xp + _gain]; } else { _arr set [_i, [_job, _xp + _gain]]; };
    [_unit, "job_xp", _arr] call CORE_fnc_setValue;
    CORE_flushSoon = true;
    [format ["[Travail] Tâche terminée : +%1 %2 sur votre compte, +%3 XP%4.", _pay, _sym, _gain, _extra]] call _msg;
    private _nl = [_job, _xp + _gain] call JOB_fnc_cfgLevel;
    if ((_nl select 0) > _n) then {
        [format ["[Travail] PROMOTION ! Vous êtes maintenant %1 (niveau %2).", getText ((_nl select 1) >> "title"), _nl select 0]] call _msg;
        diag_log format ["[JOB] %1 passe niveau %2 en %3", name _unit, _nl select 0, _job];
        [_unit] call JOB_fnc_srvVehClear;   // le véhicule du nouveau niveau peut être différent
    };
    _unit setVariable ["JOB_step", 0];
    [_unit] call JOB_fnc_srvAssign;
};
[_unit] call JOB_fnc_srvSync;
