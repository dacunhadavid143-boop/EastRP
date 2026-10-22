/* Dessine le téléphone puis affiche l'accueil. params: [display]
   Mode IMAGE (réaliste) si les .paa existent dans phoneSystem\img, sinon dessin vectoriel de secours. */
disableSerialization;
params ["_d"];
uiNamespace setVariable ["PHN_display", _d];
PHN_page = [];
PHN_chrome = [];
PHN_refs = createHashMap;
uiNamespace setVariable ["PHN_clock", controlNull];

private _cfg = missionConfigFile >> "PHN_Settings";
private _scale = getNumber (_cfg >> "uiScale");
if (_scale <= 0) then { _scale = 0.86; };
private _pw = pixelW;
private _ph = pixelH;
private _sh = safeZoneH * _scale;                  // hauteur de l'écran du téléphone
private _shpx = _sh / _ph;
private _swpx = _shpx * (440 / 956);               // proportions d'un iPhone 17 Pro Max (écran 440 x 956)
private _sw = _swpx * _pw;
private _x0 = safeZoneX + safeZoneW / 2 - _sw / 2;
private _y0 = safeZoneY + safeZoneH / 2 - _sh / 2;
PHN_S = [_x0, _y0, _sw, _sh];
PHN_C = [_x0, _y0 + 0.078 * _sh, _sw, 0.872 * _sh];   // zone de contenu des applications

// Mode image ?
private _wallName = format ["wall%1_ca", PHN_wall mod 3];
PHN_imgMode = (getNumber (_cfg >> "useImages") == 1) && {([_wallName] call PHN_fnc_img) != ""} && {(["frame_ca"] call PHN_fnc_img) != ""};

if (PHN_imgMode) then {
    // ---------- RENDU RÉALISTE (images lissées) ----------
    private _c1 = [_x0, _y0, _sw, _sh, _wallName] call PHN_fnc_uiPic;
    PHN_chrome pushBack _c1;
    // cadre : le "trou" de l'image (884 x 1920 px) correspond exactement à l'écran
    private _fx = _sw / 884;
    private _fy = _sh / 1920;
    PHN_chrome pushBack ([_x0 - 70 * _fx, _y0 - 64 * _fy, 1024 * _fx, 2048 * _fy, "frame_ca"] call PHN_fnc_uiPic);
} else {
    // ---------- DESSIN VECTORIEL DE SECOURS ----------
    private _bpx = 0.011 * _shpx;
    private _rpx = 0.125 * _swpx;
    private _o = _bpx + 3;
    PHN_chrome append ([_x0 - _o * _pw, _y0 - _o * _ph, _sw + 2 * _o * _pw, _sh + 2 * _o * _ph, _rpx + _o, [0.58,0.54,0.50,1], [0.40,0.37,0.34,1]] call PHN_fnc_roundRect);
    PHN_chrome append ([_x0 + _sw + (_o - 1) * _pw, _y0 + 0.26 * _sh, 4 * _pw, 0.10 * _sh, 2, [0.45,0.42,0.39,1]] call PHN_fnc_roundRect);
    PHN_chrome append ([_x0 - (_o + 3) * _pw, _y0 + 0.20 * _sh, 4 * _pw, 0.06 * _sh, 2, [0.45,0.42,0.39,1]] call PHN_fnc_roundRect);
    PHN_chrome append ([_x0 - (_o + 3) * _pw, _y0 + 0.28 * _sh, 4 * _pw, 0.06 * _sh, 2, [0.45,0.42,0.39,1]] call PHN_fnc_roundRect);
    PHN_chrome append ([_x0 - _bpx * _pw, _y0 - _bpx * _ph, _sw + 2 * _bpx * _pw, _sh + 2 * _bpx * _ph, _rpx + _bpx, [0,0,0,1]] call PHN_fnc_roundRect);
    private _walls = [
        [[0.07,0.09,0.30,1], [0.50,0.20,0.58,1]],
        [[0.04,0.22,0.34,1], [0.10,0.58,0.52,1]],
        [[0.28,0.07,0.10,1], [0.90,0.48,0.22,1]]
    ];
    private _w = _walls select (PHN_wall mod (count _walls));
    PHN_chrome append ([_x0, _y0, _sw, _sh, _rpx, _w select 0, _w select 1] call PHN_fnc_roundRect);
};

// Barre d'état, île dynamique, barre d'accueil
[false] call PHN_fnc_uiStatus;

// Première page : appel en cours, sinon accueil
if ((PHN_call select 0) != "idle") then {
    [PHN_fnc_pgCall, []] call PHN_fnc_showPage;
} else {
    [PHN_fnc_homePage, []] call PHN_fnc_showPage;
};
[] spawn PHN_fnc_clockLoop;
