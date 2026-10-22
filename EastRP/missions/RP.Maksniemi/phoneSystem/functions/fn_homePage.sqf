/* Écran d'accueil : grille d'applications + dock */
private _perm = { params ["_a"]; [_a select 5] call PHN_fnc_hasPermClient };
private _grid = PHN_apps select { !(_x select 6) && {[_x] call _perm} };
private _dock = (PHN_apps select { (_x select 6) && {[_x] call _perm} }) select [0, 4];
private _c = PHN_C;
private _fw = 0.19;
private _fh = [_fw] call PHN_fnc_squareH;
private _iconPx = (_fw * (_c select 2)) / pixelW;
private _rad = 0.225 * _iconPx;

private _icon = {
    params ["_app", "_fx", "_fy", "_label"];
    private _col = _app select 2;
    private _ax = (_c select 0) + _fx * (_c select 2);
    private _ay = (_c select 1) + _fy * (_c select 3);
    private _aw = _fw * (_c select 2);
    private _ah = _fh * (_c select 3);
    [_app select 0, _ax, _ay, _aw, _ah, _col, _app select 3] call PHN_fnc_uiAppIcon;
    if (_label) then { [_fx - 0.03, _fy + _fh + 0.004, _fw + 0.06, 0.04, _app select 1, 0.022, [1,1,1,1], "center"] call PHN_fnc_uiText; };
    [_fx - 0.02, _fy, _fw + 0.04, _fh + (if (_label) then { 0.045 } else { 0 }), "", [0,0,0,0], [1,1,1,1], { [_this select 0] call PHN_fnc_openApp; }, _app select 0, 0, 0.02] call PHN_fnc_uiButton;
};

{
    private _col = _forEachIndex mod 4;
    private _row = floor (_forEachIndex / 4);
    [_x, 0.03 + _col * 0.25, 0.04 + _row * (_fh + 0.075), true] call _icon;
} forEach _grid;

// Dock
private _dh = _fh + 0.03;
private _dy = 0.985 - _dh;
private _dockPic = if (PHN_imgMode) then { [(_c select 0) + 0.03 * (_c select 2), (_c select 1) + _dy * (_c select 3), 0.94 * (_c select 2), _dh * (_c select 3), "dock_ca"] call PHN_fnc_uiPic } else { controlNull };
if (!isNull _dockPic) then { PHN_page pushBack _dockPic; } else {
    [0.03, _dy, 0.94, _dh, [1,1,1,0.24], 0.2 * (_dh * (_c select 3)) / pixelH] call PHN_fnc_uiRect;
};
{
    [_x, 0.03 + _forEachIndex * 0.235 + (0.235 - _fw) / 2, _dy + 0.015, false] call _icon;
} forEach _dock;
PHN_atHome = true;
