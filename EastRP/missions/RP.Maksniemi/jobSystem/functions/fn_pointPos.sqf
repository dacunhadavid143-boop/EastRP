/* Position d'un point de travail (marqueur ou objet nommé). params: [nom] */
params ["_n"];
if (getMarkerType _n != "") exitWith { getMarkerPos _n };
private _o = missionNamespace getVariable [_n, objNull];
if (_o isEqualType objNull && {!isNull _o}) exitWith { getPosATL _o };
[0, 0, 0]
