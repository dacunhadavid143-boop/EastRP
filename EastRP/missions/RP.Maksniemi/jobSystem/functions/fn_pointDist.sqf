/* Distance (m) entre un joueur et un point de travail : jusqu'à la surface pour un objet, jusqu'au centre pour un marqueur. params: [unit, nom] */
params ["_u", "_n"];
if (getMarkerType _n != "") exitWith { _u distance2D (getMarkerPos _n) };
private _o = missionNamespace getVariable [_n, objNull];
if !(_o isEqualType objNull) exitWith { 1e6 };
if (isNull _o) exitWith { 1e6 };
[_o, _u] call ECO_fnc_boxDist
