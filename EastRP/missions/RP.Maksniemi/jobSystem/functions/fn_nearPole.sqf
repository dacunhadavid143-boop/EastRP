/* SERVEUR : true si le joueur est près d'un Pôle Emploi (objet ou marqueur nommé job_pole_*, ou bâtiment listé dans poleClasses). params: [unit] */
params ["_unit"];
private _cfg = missionConfigFile >> "JOB_Settings";
private _dist = getNumber (_cfg >> "poleDistance");
if ((["job_pole"] call JOB_fnc_pointList) findIf { ([_unit, _x] call JOB_fnc_pointDist) <= _dist } != -1) exitWith { true };
private _cls = (getArray (_cfg >> "poleClasses")) apply { toLower _x };
private _near = nearestObjects [_unit, [], _dist + 20, true];
(_near findIf { private _t = toLower typeOf _x; (_cls findIf { (_t find _x) == 0 }) != -1 }) != -1
