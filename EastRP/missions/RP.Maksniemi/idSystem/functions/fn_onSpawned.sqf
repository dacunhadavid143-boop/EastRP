/* Événement SPN_spawned. params: [unit, pointId] */
params ["_unit"];
[_unit] call DOC_fnc_giveItems;
[_unit] call DOC_fnc_initUnit;
