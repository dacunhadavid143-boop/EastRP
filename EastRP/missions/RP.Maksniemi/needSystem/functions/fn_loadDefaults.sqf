/* SERVEUR : initialise faim/soif d'un joueur qui n'en a pas encore. params: [unit, (uid)] */
if (!isServer) exitWith {};
params ["_unit"];
private _s = getNumber (missionConfigFile >> "NEED_Settings" >> "start");
if (([_unit, "hunger", -1] call CORE_fnc_getValue) < 0) then { [_unit, "hunger", _s] call CORE_fnc_setValue; };
if (([_unit, "thirst", -1] call CORE_fnc_getValue) < 0) then { [_unit, "thirst", _s] call CORE_fnc_setValue; };
[_unit] call NEED_fnc_sync;
diag_log format ["[NEED] faim/soif synchronisées pour %1 : %2 / %3", name _unit, [_unit, "hunger", -1] call CORE_fnc_getValue, [_unit, "thirst", -1] call CORE_fnc_getValue];
diag_log format ["[NEED] faim/soif synchronisées pour %1", name _unit];
