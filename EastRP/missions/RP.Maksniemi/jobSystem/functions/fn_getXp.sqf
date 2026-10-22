/* SERVEUR : expérience d'un joueur dans un métier. params: [unit, métier] */
params ["_unit", "_job"];
private _arr = [_unit, "job_xp", []] call CORE_fnc_getValue;
if !(_arr isEqualType []) exitWith { 0 };
private _i = _arr findIf { _x isEqualType [] && {(_x select 0) == _job} };
if (_i < 0) then { 0 } else { (_arr select _i) select 1 }
