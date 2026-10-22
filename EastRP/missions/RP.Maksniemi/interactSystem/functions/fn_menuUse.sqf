/* Lance l'action choisie. params: [index] */
params ["_i"];
if (_i < 0 || {_i >= count INT_menuItems}) exitWith {};
private _it = INT_menuItems select _i;
if (getNumber (missionConfigFile >> "INT_Settings" >> "debug") == 1) then { systemChat format ["[INT debug] option choisie : %1 (cible : %2)", _it select 1, _it select 3]; };
closeDialog 0;
[_it select 3] spawn (_it select 2);
