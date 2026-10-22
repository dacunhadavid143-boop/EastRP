/* Position (AGL) juste au-dessus d'un point de travail : sommet de l'objet, ou 2 m au-dessus d'un marqueur. params: [nom] */
params ["_n"];
if (getMarkerType _n != "") exitWith { (getMarkerPos _n) vectorAdd [0, 0, 2] };
private _o = missionNamespace getVariable [_n, objNull];
if (!(_o isEqualType objNull) || {isNull _o}) exitWith { [] };
private _bb = boundingBoxReal _o;
(_o modelToWorld [0, 0, (_bb select 1) select 2]) vectorAdd [0, 0, 0.6]
