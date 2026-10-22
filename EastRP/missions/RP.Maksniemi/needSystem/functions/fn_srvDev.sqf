/* SERVEUR (devMode) : outil de test. params: [unit, "hunger"|"thirst", delta] */
if (!isServer) exitWith {};
if (getNumber (missionConfigFile >> "CORE_Settings" >> "devMode") != 1) exitWith {};
params [["_unit", objNull, [objNull]], "_key", "_delta"];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_key in ["hunger", "thirst"]) exitWith {};
[_unit, _key, (([_unit, _key, 100] call CORE_fnc_getValue) + _delta) min 100 max 0] call CORE_fnc_setValue;
[_unit] call NEED_fnc_sync;
