/* Rectangle dans la page. Coordonnées en FRACTIONS de la zone de contenu (0..1). params: [fx, fy, fw, fh, couleur, rayonPx (0 = angles droits), couleurBas (optionnel)] */
params ["_fx", "_fy", "_fw", "_fh", ["_col", [1,1,1,1]], ["_r", 0], ["_col2", []]];
private _c = PHN_C;
private _ax = (_c select 0) + _fx * (_c select 2);
private _ay = (_c select 1) + _fy * (_c select 3);
private _aw = _fw * (_c select 2);
private _ah = _fh * (_c select 3);
private _arr = [_ax, _ay, _aw, _ah, _r, _col, _col2] call PHN_fnc_roundRect;
PHN_page append _arr;
_arr
