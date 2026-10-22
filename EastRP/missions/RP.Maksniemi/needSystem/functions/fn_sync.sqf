/* SERVEUR : envoie faim/soif au client propriétaire uniquement. params: [unit] */
if (!isServer) exitWith {};
params ["_unit"];
private _o = owner _unit;
_unit setVariable ["NEED_hunger", [_unit, "hunger", 100] call CORE_fnc_getValue, _o];
_unit setVariable ["NEED_thirst", [_unit, "thirst", 100] call CORE_fnc_getValue, _o];
