/* Fond plein écran d'une application (couleur unie, coins arrondis comme l'écran), avec barre d'état redessinée par-dessus.
   Utilise l'image lissée screen_ca si elle existe (1 seul contrôle), sinon dessin vectoriel.
   params: [couleurFond, couleurEntête (optionnel : bandeau en haut), basDuBandeau (fraction de la zone de contenu, optionnel)] */
params [["_col", [0,0,0,1]], ["_hdrCol", []], ["_hdrBottom", 0.1]];
PHN_S params ["_x0", "_y0", "_sw", "_sh"];
private _rpx = 0.125 * _sw / pixelW;
private _bg = [_x0, _y0, _sw, _sh, "screen_ca", _col] call PHN_fnc_uiPic;
if (isNull _bg) then {
    PHN_page append ([_x0, _y0, _sw, _sh, _rpx, _col] call PHN_fnc_roundRect);
} else {
    PHN_page pushBack _bg;
};
if (_hdrCol isNotEqualTo []) then {
    private _c = PHN_C;
    private _hb = (_c select 1) + _hdrBottom * (_c select 3);
    PHN_page append ([_x0, _y0, _sw, 2 * _rpx * pixelH, _rpx, _hdrCol] call PHN_fnc_roundRect);                              // haut arrondi
    PHN_page append ([_x0, _y0 + _rpx * pixelH, _sw, _hb - (_y0 + _rpx * pixelH), 0, _hdrCol] call PHN_fnc_roundRect);        // bas droit
};
if (!isNull (uiNamespace getVariable ["PHN_homeBtnChrome", controlNull])) then { (uiNamespace getVariable "PHN_homeBtnChrome") ctrlEnable false; };
[true] call PHN_fnc_uiStatus;
