/* SERVEUR : envoie l'état d'emploi au joueur (variable JOB_state, visible par lui seul). params: [unit]
   JOB_state = [0 métier, 1 niveau, 2 poste, 3 xp, 4 xp niveau suivant, 5 étape, 6 texte étape, 7 point imposé, 8 en service,
                9 contrat effectué (s), 10 contrat minimum (s), 11 xp de tous les métiers, 12 carence restante (min), 13 préfixe étape,
                14 durée étape (s), 15 nombre d'étapes, 16 nom du métier, 17 salaire par tâche,
                18 spécial de l'étape ("", "veh", "vehget", "quiz:..."), 19 question du mini-jeu [texte, réponses], 20 GPS (1/0)] */
params ["_unit"];
if (isNull _unit) exitWith {};
private _cfg = missionConfigFile >> "JOB_Settings";
private _job = [_unit, "job", ""] call CORE_fnc_getValue;
private _xpList = [_unit, "job_xp", []] call CORE_fnc_getValue;
if !(_xpList isEqualType []) then { _xpList = []; };
private _lock = ceil ((([_unit, "job_quitAt", -1e9] call CORE_fnc_getValue) + getNumber (_cfg >> "quitCooldownMinutes") - (call JOB_fnc_nowMin)) max 0);
private _min = 60 * getNumber (_cfg >> "minContractMinutes");
private _st = ["", 0, "", 0, -1, 0, "", "", false, 0, _min, _xpList, _lock, "", 0, 0, "", 0, "", [], 0];
if (_job != "") then {
    private _jc = missionConfigFile >> "JOB_Jobs" >> _job;
    private _xp = [_unit, _job] call JOB_fnc_getXp;
    (([_job, _xp] call JOB_fnc_cfgLevel)) params ["_n", "_lc", "_next"];
    private _steps = getArray (_lc >> "steps");
    private _idx = (_unit getVariable ["JOB_step", 0]) min ((count _steps - 1) max 0);
    private _step = if (_steps isEqualTo []) then { ["", "", 0] } else { _steps select _idx };
    private _ov = _unit getVariable ["JOB_stepOverride", []];
    if (count _ov == 2) then { _step = +_step; _step set [0, _ov select 0]; _step set [1, _ov select 1]; };
    private _gps = if (isNumber (_lc >> "gps")) then { getNumber (_lc >> "gps") } else { getNumber (_jc >> "gps") };
    _st = [_job, _n, getText (_lc >> "title"), _xp, _next, _idx, _step select 1, _unit getVariable ["JOB_assigned", ""],
           _unit getVariable ["JOB_duty", false], [_unit, "job_contract", 0] call CORE_fnc_getValue, _min, _xpList, _lock,
           _step select 0, _step select 2, count _steps, getText (_jc >> "displayName"), getNumber (_lc >> "pay"),
           _step param [6, ""], _unit getVariable ["JOB_quizQ", []], _gps];
};
_unit setVariable ["JOB_state", _st, owner _unit];
