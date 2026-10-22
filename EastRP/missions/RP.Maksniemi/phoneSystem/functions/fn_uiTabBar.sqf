/* Barre d'onglets en bas de l'application. params: [libellés, onglet actif, code (reçoit [index]), couleurBarre, couleurActive, couleurInactive] */
params ["_labels", "_active", "_code", ["_bar", [0.09,0.13,0.16,1]], ["_on", [0.15,0.83,0.40,1]], ["_off", [0.55,0.62,0.66,1]]];
[0, 0.905, 1, 0.095, _bar] call PHN_fnc_uiRect;
[0, 0.905, 1, 0.002, [1,1,1,0.08]] call PHN_fnc_uiRect;
private _n = count _labels;
{
    [_forEachIndex / _n, 0.915, 1 / _n, 0.075, _x, [0,0,0,0], if (_forEachIndex == _active) then { _on } else { _off }, _code, _forEachIndex, 0, 0.026] call PHN_fnc_uiButton;
} forEach _labels;
