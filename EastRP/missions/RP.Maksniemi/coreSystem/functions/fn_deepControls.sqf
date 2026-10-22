/* Tous les contrôles d'un display/groupe, y compris imbriqués. params: [parent] */
params ["_p"];
private _out = [];
{
    _out pushBack _x;
    if (ctrlType _x == 15) then { _out append ([_x] call CORE_fnc_deepControls); };
} forEach (allControls _p);
_out
