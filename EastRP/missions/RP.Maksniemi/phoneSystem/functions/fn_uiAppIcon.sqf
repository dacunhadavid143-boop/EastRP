/* Icône d'application (image si disponible, sinon dessin vectoriel). Coordonnées ABSOLUES. params: [id, x, y, w, h, couleur, glyphe texte] */
params ["_id", "_ax", "_ay", "_aw", "_ah", "_col", ["_glyph", ""]];
private _rad = 0.225 * _aw / pixelW;
private _base = if (PHN_imgMode) then { [_ax, _ay, _aw, _ah, "iconbase_ca", _col] call PHN_fnc_uiPic } else { controlNull };
if (!isNull _base) then {
    PHN_page pushBack _base;
    private _g = [_ax, _ay, _aw, _ah, format ["glyph_%1_ca", _id]] call PHN_fnc_uiPic;
    if (isNull _g) then { [_id, _ax, _ay, _aw, _ah, _col, _glyph] call PHN_fnc_iconGlyph; } else { PHN_page pushBack _g; };
} else {
    private _light = [_col, [1,1,1,1], 0.28] call PHN_fnc_lerpColor;
    _light set [3, 1];
    PHN_page append ([_ax, _ay, _aw, _ah, _rad, _light, _col] call PHN_fnc_roundRect);
    [_id, _ax, _ay, _aw, _ah, _col, _glyph] call PHN_fnc_iconGlyph;
};
