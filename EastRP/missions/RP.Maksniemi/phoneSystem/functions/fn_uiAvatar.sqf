/* Avatar rond (couleur + initiales). Coordonnées en fractions de la zone de contenu. params: [fx, fy, fw, indexCouleur, initiales, anneauVert(bool)] */
params ["_fx", "_fy", "_fw", "_idx", "_ini", ["_ring", false]];
private _c = PHN_C;
private _fh = [_fw] call PHN_fnc_squareH;
private _ax = (_c select 0) + _fx * (_c select 2);
private _ay = (_c select 1) + _fy * (_c select 3);
private _aw = _fw * (_c select 2);
private _ah = _fh * (_c select 3);
private _rpx = 0.5 * _aw / pixelW;
if (_ring) then {
    PHN_page append ([_ax - 3 * pixelW, _ay - 3 * pixelH, _aw + 6 * pixelW, _ah + 6 * pixelH, _rpx + 3, [0.15,0.83,0.40,1], [], 14] call PHN_fnc_roundRect);
    PHN_page append ([_ax - 1 * pixelW, _ay - 1 * pixelH, _aw + 2 * pixelW, _ah + 2 * pixelH, _rpx + 1, [0.043,0.078,0.102,1], [], 14] call PHN_fnc_roundRect);
};
private _cols = [[0.20,0.60,0.95,1],[0.90,0.35,0.35,1],[0.95,0.65,0.15,1],[0.55,0.40,0.90,1],[0.15,0.70,0.55,1],[0.90,0.40,0.70,1],[0.45,0.55,0.65,1],[0.80,0.50,0.25,1]];
PHN_page append ([_ax, _ay, _aw, _ah, _rpx, _cols select (_idx mod 8), [], 14] call PHN_fnc_roundRect);
[_fx, _fy + _fh * 0.2, _fw, _fh * 0.6, _ini, _fh * 0.42, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
