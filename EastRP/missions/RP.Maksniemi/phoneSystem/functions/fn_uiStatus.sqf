/* Dessine l'île dynamique, la barre d'état (heure, réseau, batterie) et la barre d'accueil.
   params: [surLaPage (false = cadre permanent, true = redessiné au-dessus d'une page plein écran)] */
disableSerialization;
params [["_toPage", false]];
PHN_S params ["_x0", "_y0", "_sw", "_sh"];
private _pw = pixelW;
private _ph = pixelH;
private _store = if (_toPage) then { PHN_page } else { PHN_chrome };

// Île dynamique
private _iw = 0.30 * _sw;
private _ih = 0.034 * _sh;
private _ix = _x0 + (_sw - _iw) / 2;
private _iy = _y0 + 0.014 * _sh;
private _isl = [_ix, _iy, _iw, _ih, "island_ca"] call PHN_fnc_uiPic;
if (isNull _isl) then { _store append ([_ix, _iy, _iw, _ih, (_ih / _ph) / 2, [0,0,0,1]] call PHN_fnc_roundRect); } else { _store pushBack _isl; };

// Heure
private _clk = (uiNamespace getVariable "PHN_display") ctrlCreate ["PHN_RscTextC", -1];
_clk ctrlSetPosition [_x0 + 0.06 * _sw, _y0 + 0.014 * _sh, 0.24 * _sw, 0.036 * _sh];
_clk ctrlSetFont "PuristaBold";
_clk ctrlSetFontHeight (0.022 * _sh);
_clk ctrlSetText "00:00";
_clk ctrlCommit 0;
_store pushBack _clk;
uiNamespace setVariable ["PHN_clock", _clk];

// Réseau et batterie
for "_i" from 0 to 3 do {
    private _bh = (0.006 + 0.004 * _i) * _sh;
    _store append ([_x0 + (0.64 + 0.032 * _i) * _sw, _y0 + 0.0405 * _sh - _bh, 0.02 * _sw, _bh, 1, [1,1,1,0.95]] call PHN_fnc_roundRect);
};
_store append ([_x0 + 0.81 * _sw, _y0 + 0.0255 * _sh, 0.085 * _sw, 0.0155 * _sh, 4, [1,1,1,0.92]] call PHN_fnc_roundRect);
_store append ([_x0 + 0.897 * _sw, _y0 + 0.0295 * _sh, 0.007 * _sw, 0.0075 * _sh, 1, [1,1,1,0.7]] call PHN_fnc_roundRect);

// Barre d'accueil + zone cliquable (retour à l'accueil, ou fermeture si on y est déjà)
private _hbx = _x0 + 0.32 * _sw;
private _hby = _y0 + _sh - 0.012 * _sh - 6 * _ph;
private _hbp = [_hbx, _hby, 0.36 * _sw, 6 * _ph, "homebar_ca"] call PHN_fnc_uiPic;
if (isNull _hbp) then { _store append ([_hbx, _hby, 0.36 * _sw, 6 * _ph, 3, [1,1,1,0.9]] call PHN_fnc_roundRect); } else { _store pushBack _hbp; };
private _hb = (uiNamespace getVariable "PHN_display") ctrlCreate ["PHN_RscButtonFlat", -1];
_hb ctrlSetPosition [_x0 + 0.22 * _sw, _y0 + 0.95 * _sh, 0.56 * _sw, 0.045 * _sh];
_hb ctrlAddEventHandler ["ButtonClick", {
    if (PHN_atHome) then { closeDialog 0; } else { [PHN_fnc_homePage, []] call PHN_fnc_showPage; };
}];
_hb ctrlCommit 0;
_store pushBack _hb;
if (!_toPage) then { uiNamespace setVariable ["PHN_homeBtnChrome", _hb]; };
