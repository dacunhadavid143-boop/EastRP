/* SERVEUR : prendre / terminer son service sur le lieu de travail. params: [unit, marqueur du lieu de travail] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_mk", "", [""]]];
_mk = toLower _mk;
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
private _msg = { params ["_m"]; [_m] remoteExec ["CORE_fnc_clientMsg", _unit]; };
private _job = [_unit, "job", ""] call CORE_fnc_getValue;
if (_job == "") exitWith { ["[Travail] Vous n'avez pas d'emploi. Passez au Pôle Emploi."] call _msg; };
if ((_mk find format ["job_%1_service", _job]) != 0) exitWith { ["[Travail] Ce n'est pas votre lieu de travail."] call _msg; };
if (([_unit, _mk] call JOB_fnc_pointDist) > getNumber (missionConfigFile >> "JOB_Settings" >> "pointRadius") + 3) exitWith { ["[Travail] Vous êtes trop loin."] call _msg; };

if (_unit getVariable ["JOB_duty", false]) then {
    _unit setVariable ["JOB_duty", false];
    [_unit] call JOB_fnc_srvVehClear;
    ["[Travail] Fin de service. À bientôt !"] call _msg;
} else {
    _unit setVariable ["JOB_duty", true];
    _unit setVariable ["JOB_step", 0];
    _unit setVariable ["JOB_lastTask", time];
    _unit setVariable ["JOB_stepT", time];
    _unit setVariable ["JOB_penalty", false];
    [_unit] call JOB_fnc_srvAssign;
    private _lv = [_job, [_unit, _job] call JOB_fnc_getXp] call JOB_fnc_cfgLevel;
    private _steps = getArray ((_lv select 1) >> "steps");
    [format ["[Travail] Prise de service : %1. Première tâche : %2 (suivez le repère).", getText ((_lv select 1) >> "title"), if (_steps isEqualTo []) then { "?" } else { (_steps select 0) select 1 }]] call _msg;
};
[_unit] call JOB_fnc_srvSync;
