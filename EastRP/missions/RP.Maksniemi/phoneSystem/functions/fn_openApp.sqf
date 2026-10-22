/* Ouvre une application par son id. params: [id] */
params ["_id"];
private _i = PHN_apps findIf { (_x select 0) == _id };
if (_i < 0) exitWith {};
[(PHN_apps select _i) select 4, []] call PHN_fnc_showPage;
