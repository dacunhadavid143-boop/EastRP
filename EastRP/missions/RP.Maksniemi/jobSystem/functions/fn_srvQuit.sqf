/* SERVEUR : démissionner (au Pôle Emploi), seulement après le contrat minimum. params: [unit] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
private _msg = { params ["_m"]; [_m] remoteExec ["CORE_fnc_clientMsg", _unit]; };
private _cfg = missionConfigFile >> "JOB_Settings";
private _job = [_unit, "job", ""] call CORE_fnc_getValue;
if (_job == "") exitWith { ["[Pôle Emploi] Vous n'avez pas d'emploi."] call _msg; };
if !([_unit] call JOB_fnc_nearPole) exitWith { ["[Pôle Emploi] Vous devez être au Pôle Emploi."] call _msg; };
private _left = 60 * getNumber (_cfg >> "minContractMinutes") - ([_unit, "job_contract", 0] call CORE_fnc_getValue);
if (_left > 0) exitWith { [format ["[Pôle Emploi] Contrat minimum non terminé : encore %1 de travail en service.", [_left] call JOB_fnc_fmtDur]] call _msg; };

[_unit, "job", ""] call CORE_fnc_setValue;
[_unit, "job_contract", 0] call CORE_fnc_setValue;
[_unit, "job_quitAt", call JOB_fnc_nowMin] call CORE_fnc_setValue;
_unit setVariable ["JOB_duty", false];
_unit setVariable ["JOB_assigned", ""];
[_unit] call JOB_fnc_srvVehClear;
[_unit] call JOB_fnc_srvSync;
CORE_flushSoon = true;
[format ["[Pôle Emploi] Démission enregistrée. Votre expérience est conservée. Nouvelle inscription possible dans %1.",
    [60 * getNumber (_cfg >> "quitCooldownMinutes")] call JOB_fnc_fmtDur]] call _msg;
diag_log format ["[JOB] %1 démissionne : %2", name _unit, _job];
