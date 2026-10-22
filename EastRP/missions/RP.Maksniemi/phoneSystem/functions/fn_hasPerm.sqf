/* SERVEUR : params: [unit, permission] -> true/false */
params ["_unit", "_perm"];
_perm in (([_unit] call PHN_fnc_srvRole) select 1)
