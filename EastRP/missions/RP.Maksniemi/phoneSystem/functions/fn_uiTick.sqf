/* Coche (✓) dessinée avec de petits carrés, simple ou double. Coordonnées ABSOLUES. params: [x, y, taille en pixels, couleur, double(bool)] */
params ["_ax", "_ay", "_s", "_col", ["_double", false]];
private _pw = pixelW;
private _ph = pixelH;
private _draw = {
    params ["_ox"];
    for "_i" from 0 to 4 do {
        PHN_page append ([_ax + _ox * _pw + (_i * 0.38 * _s / 4) * _pw, _ay + (0.52 * _s + _i * 0.40 * _s / 4) * _ph, 2 * _pw, 2 * _ph, 0, _col] call PHN_fnc_roundRect);
    };
    for "_i" from 0 to 8 do {
        PHN_page append ([_ax + _ox * _pw + (0.38 * _s + _i * 0.62 * _s / 8) * _pw, _ay + (0.92 * _s - _i * 0.78 * _s / 8) * _ph, 2 * _pw, 2 * _ph, 0, _col] call PHN_fnc_roundRect);
    };
};
[0] call _draw;
if (_double) then { [0.42 * _s] call _draw; };
