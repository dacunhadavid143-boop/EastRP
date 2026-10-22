/* Petits pictogrammes dessinés (flèche, carte, infos, plus). Coordonnées ABSOLUES. params: [genre, x, y, w, h, couleur] */
params ["_k", "_ax", "_ay", "_aw", "_ah", "_col"];
private _r = {
    params ["_fx", "_fy", "_fw", "_fh", "_rad"];
    PHN_page append ([_ax + _fx * _aw, _ay + _fy * _ah, _fw * _aw, _fh * _ah, _rad, _col, [], 6] call PHN_fnc_roundRect);
};
switch (_k) do {
    case "send": {                                  // flèche vers le haut
        [0.45, 0.30, 0.10, 0.45, 1] call _r;
        for "_i" from 0 to 6 do { [0.50 - 0.04 * (_i + 1), 0.22 + _i * 0.035, 0.08 * (_i + 1), 0.04, 0] call _r; };
    };
    case "card": {
        [0.22, 0.30, 0.56, 0.40, 3] call _r;
    };
    case "info": {
        [0.28, 0.32, 0.44, 0.07, 1] call _r;
        [0.28, 0.47, 0.44, 0.07, 1] call _r;
        [0.28, 0.62, 0.30, 0.07, 1] call _r;
    };
    case "plus": {
        [0.25, 0.46, 0.50, 0.08, 1] call _r;
        [0.46, 0.25, 0.08, 0.50, 1] call _r;
    };
};
