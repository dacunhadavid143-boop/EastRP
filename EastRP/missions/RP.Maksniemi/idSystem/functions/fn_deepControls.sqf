/* Renvoie tous les contrôles d'un display/groupe, y compris ceux imbriqués dans des groupes. params: [parent] */
params ["_p"];
private _out = [];
{
    _out pushBack _x;
    if (ctrlType _x == 15) then { _out append ([_x] call DOC_fnc_deepControls); };   // CT_CONTROLS_GROUP
} forEach (allControls _p);
_out
