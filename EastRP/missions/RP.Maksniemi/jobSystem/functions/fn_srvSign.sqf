/* SERVEUR : signer un contrat au Pôle Emploi. params: [unit, métier] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_job", "", [""]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
private _msg = { params ["_m"]; [_m] remoteExec ["CORE_fnc_clientMsg", _unit]; };
private _jc = missionConfigFile >> "JOB_Jobs" >> _job;
if (_job == "" || {!isClass _jc}) exitWith { ["[Pôle Emploi] Métier inconnu."] call _msg; };
if !([_unit] call JOB_fnc_nearPole) exitWith { ["[Pôle Emploi] Vous devez être au Pôle Emploi."] call _msg; };
private _cur = [_unit, "job", ""] call CORE_fnc_getValue;
if (_cur != "") exitWith { [format ["[Pôle Emploi] Vous avez déjà un emploi (%1). Démissionnez d'abord.", getText (missionConfigFile >> "JOB_Jobs" >> _cur >> "displayName")]] call _msg; };
private _lock = ([_unit, "job_quitAt", -1e9] call CORE_fnc_getValue) + getNumber (missionConfigFile >> "JOB_Settings" >> "quitCooldownMinutes") - (call JOB_fnc_nowMin);
if (_lock > 0) exitWith { [format ["[Pôle Emploi] Vous avez démissionné récemment. Nouvelle inscription possible dans %1.", [ceil (_lock * 60) max 60] call JOB_fnc_fmtDur]] call _msg; [_unit] call JOB_fnc_srvSync; };

[_unit, "job", _job] call CORE_fnc_setValue;
[_unit, "job_contract", 0] call CORE_fnc_setValue;
_unit setVariable ["JOB_duty", false];
_unit setVariable ["JOB_step", 0];
[_unit] call JOB_fnc_srvAssign;
[_unit] call JOB_fnc_srvSync;
CORE_flushSoon = true;
private _lv = [_job, [_unit, _job] call JOB_fnc_getXp] call JOB_fnc_cfgLevel;
[format ["[Pôle Emploi] Contrat signé : %1 (niveau %2 : %3). Rendez-vous sur votre lieu de travail pour prendre votre service.",
    getText (_jc >> "displayName"), _lv select 0, getText ((_lv select 1) >> "title")]] call _msg;
diag_log format ["[JOB] %1 signe un contrat : %2", name _unit, _job];
