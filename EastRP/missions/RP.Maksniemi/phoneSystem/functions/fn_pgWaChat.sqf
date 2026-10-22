/* Chat : conversation avec un numéro. params: [numéro] */
params ["_num"];
private _c = PHN_C;
private _my = player getVariable ["PHN_number", ""];
[PHN_wBg, PHN_wPanel, 0.105] call PHN_fnc_uiAppBg;

private _p = [_num] call PHN_fnc_waProfileOf;
private _name = [_num] call PHN_fnc_waName;
private _av = if (_p isEqualTo []) then { parseNumber (_num select [6, 1]) } else { _p select 1 };
[0.01, 0.016, 0.14, 0.065, "<", [0,0,0,0], PHN_wGreen, { [PHN_fnc_pgWaChats, []] call PHN_fnc_showPage; }, [], 0, 0.05] call PHN_fnc_uiButton;
[0.14, 0.012, 0.10, _av, [_name] call PHN_fnc_waInitials] call PHN_fnc_uiAvatar;
[0.27, 0.012, 0.65, 0.04, _name, 0.030, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
[0.27, 0.052, 0.65, 0.03, if (_p isEqualTo []) then { "" } else { _p select 2 }, 0.021, PHN_wGray] call PHN_fnc_uiText;

private _thread = (player getVariable ["PHN_waMsgs", []]) select { ((_x select 2) == _num && {(_x select 3) == _my}) || {(_x select 2) == _my && {(_x select 3) == _num}} };
private _y = 0.845;
private _tk = 22 * pixelW / (_c select 2);
for "_i" from (count _thread - 1) to 0 step -1 do {
    private _m = _thread select _i;
    private _mine = (_m select 2) == _my;
    private _t = _m select 4;
    private _lines = ((ceil ((count _t) / 26)) max 1);
    private _h = 0.024 + 0.026 * _lines + 0.030;
    private _w = (0.22 + 0.022 * ((count _t) min 26)) min 0.80;
    _y = _y - _h - 0.012;
    if (_y < 0.12) exitWith {};
    private _bx = if (_mine) then { 0.97 - _w } else { 0.03 };
    [_bx, _y, _w, _h, if (_mine) then { PHN_wOut } else { PHN_wPanel }, 10] call PHN_fnc_uiRect;
    private _s = (uiNamespace getVariable "PHN_display") ctrlCreate ["PHN_RscStruct", -1];
    _s ctrlSetPosition [(_c select 0) + (_bx + 0.03) * (_c select 2), (_c select 1) + (_y + 0.013) * (_c select 3), (_w - 0.06) * (_c select 2), 0.026 * _lines * (_c select 3)];
    _s ctrlSetStructuredText parseText format ["<t size='%2'>%1</t>", [_t] call PHN_fnc_esc, (_c select 3) / 0.62];
    _s ctrlCommit 0;
    PHN_page pushBack _s;
    private _right = _bx + _w - 0.03;
    [_right - (if (_mine) then { _tk } else { 0 }) - 0.15, _y + _h - 0.033, 0.15, 0.028, [_m select 1] call PHN_fnc_waTimeLabel, 0.019, PHN_wGray, "right"] call PHN_fnc_uiText;
    if (_mine) then {
        [(_c select 0) + _right * (_c select 2) - 18 * pixelW, (_c select 1) + (_y + _h - 0.030) * (_c select 3), 11, if ((_m select 5) == 2) then { PHN_wBlue } else { PHN_wGray }, (_m select 5) >= 1] call PHN_fnc_uiTick;
    };
};
if (_thread isEqualTo []) then { [0.05, 0.40, 0.9, 0.05, "Aucun message. Écrivez le premier.", 0.026, PHN_wGray, "center"] call PHN_fnc_uiText; };

// Saisie
[0.0, 0.855, 1, 0.07, PHN_wPanel] call PHN_fnc_uiRect;
[0.03, 0.862, 0.77, 0.056, "", 0.030, "msg"] call PHN_fnc_uiEdit;
private _sw = 0.12;
private _sh = [_sw] call PHN_fnc_squareH;
[0.85, 0.858, _sw, _sh, ">", PHN_wGreen, [0.04, 0.08, 0.10, 1], {
    params ["_n"];
    private _t = ctrlText (PHN_refs getOrDefault ["msg", controlNull]);
    if ((_t splitString " ") isEqualTo []) exitWith {};
    [player, _n, _t] remoteExec ["PHN_fnc_srvWaSend", 2];
    (PHN_refs get "msg") ctrlSetText "";
    [0.6] call PHN_fnc_refresh;
}, _num, 0.5 * (_sw * (_c select 2)) / pixelW, 0.04] call PHN_fnc_uiButton;

// Marque comme lu (coches bleues chez l'autre)
if (_thread findIf { (_x select 3) == _my && {(_x select 5) < 2} } >= 0) then { [player, _num] remoteExec ["PHN_fnc_srvWaRead", 2]; };
