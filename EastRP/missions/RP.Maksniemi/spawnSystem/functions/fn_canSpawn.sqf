/* SPN_fnc_canSpawn : true si toutes les conditions enregistrées sont remplies. params: [point] */
params ["_point"];
private _ok = true;
{ if !(_point call _x) exitWith { _ok = false; }; } forEach SPN_conditions;
_ok
