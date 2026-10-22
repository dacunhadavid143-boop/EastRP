/* Chat : liste des discussions */
PHN_waTab = 1;
[PHN_wBg] call PHN_fnc_uiAppBg;
private _c = PHN_C;
[0.05, 0.012, 0.7, 0.065, "Discussions", 0.050, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
private _bw = 0.11;
private _bh = [_bw] call PHN_fnc_squareH;
[0.85, 0.014, _bw, _bh, "+", PHN_wGreen, [0.04, 0.08, 0.10, 1], { [PHN_fnc_pgWaNew, []] call PHN_fnc_showPage; }, [], 0.5 * (_bw * (_c select 2)) / pixelW, 0.04] call PHN_fnc_uiButton;

private _my = player getVariable ["PHN_number", ""];
private _map = createHashMap;
{
    private _o = if ((_x select 2) == _my) then { _x select 3 } else { _x select 2 };
    private _e = _map getOrDefault [_o, [[], 0]];
    _e set [0, _x];
    if ((_x select 3) == _my && {(_x select 5) < 2}) then { _e set [1, (_e select 1) + 1]; };
    _map set [_o, _e];
} forEach (player getVariable ["PHN_waMsgs", []]);
private _convs = (keys _map) apply { [_x, (_map get _x) select 0, (_map get _x) select 1] };
_convs = [_convs, [], { (_x select 1) select 1 }, "DESCEND"] call BIS_fnc_sortBy;

if (_convs isEqualTo []) then {
    [0.08, 0.40, 0.84, 0.05, "Aucune discussion", 0.032, [1,1,1,0.85], "center", "PuristaBold"] call PHN_fnc_uiText;
    [0.08, 0.46, 0.84, 0.04, "Touchez + pour écrire à quelqu'un.", 0.024, PHN_wGray, "center"] call PHN_fnc_uiText;
};

private _afw = 0.15;
private _y = 0.10;
{
    if (_forEachIndex < 7) then {
        _x params ["_num", "_last", "_unread"];
        private _p = [_num] call PHN_fnc_waProfileOf;
        private _name = [_num] call PHN_fnc_waName;
        private _av = if (_p isEqualTo []) then { parseNumber (_num select [6, 1]) } else { _p select 1 };
        [0.035, _y + 0.013, _afw, _av, [_name] call PHN_fnc_waInitials] call PHN_fnc_uiAvatar;
        [0.22, _y + 0.012, 0.50, 0.04, _name, 0.030, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
        [0.70, _y + 0.016, 0.27, 0.035, [_last select 1] call PHN_fnc_waTimeLabel, 0.021, if (_unread > 0) then { PHN_wGreen } else { PHN_wGray }, "right"] call PHN_fnc_uiText;
        private _txt = _last select 4;
        if (count _txt > 28) then { _txt = (_txt select [0, 28]) + "..."; };
        private _mine = (_last select 2) == _my;
        private _px = 0.22;
        if (_mine) then {
            [(_c select 0) + 0.22 * (_c select 2), (_c select 1) + (_y + 0.057) * (_c select 3), 11, if ((_last select 5) == 2) then { PHN_wBlue } else { PHN_wGray }, (_last select 5) >= 1] call PHN_fnc_uiTick;
            _px = 0.22 + 26 * pixelW / (_c select 2);
        };
        [_px, _y + 0.052, 0.70, 0.035, _txt, 0.024, PHN_wGray] call PHN_fnc_uiText;
        if (_unread > 0) then {
            private _bw2 = 0.075;
            private _bh2 = [_bw2] call PHN_fnc_squareH;
            [0.885, _y + 0.054, _bw2, _bh2, PHN_wGreen, 0.5 * (_bw2 * (_c select 2)) / pixelW, [], 12] call PHN_fnc_uiRect;
            [0.885, _y + 0.054 + _bh2 * 0.14, _bw2, _bh2 * 0.72, str _unread, 0.026, [0.04, 0.08, 0.10, 1], "center", "PuristaBold"] call PHN_fnc_uiText;
        };
        [0.22, _y + 0.105, 0.75, 0.0015, [1,1,1,0.07]] call PHN_fnc_uiRect;
        [0.0, _y, 1, 0.108, "", [0,0,0,0], [1,1,1,1], { [PHN_fnc_pgWaChat, [_this select 0]] call PHN_fnc_showPage; }, _num, 0, 0.02] call PHN_fnc_uiButton;
        _y = _y + 0.112;
    };
} forEach _convs;

["Statuts", "Discussions", "Vous"] params ["_t0", "_t1", "_t2"];
[[_t0, _t1, _t2], 1, { [[PHN_fnc_pgWaStatus, PHN_fnc_pgWaChats, PHN_fnc_pgWaYou] select (_this select 0), []] call PHN_fnc_showPage; }] call PHN_fnc_uiTabBar;
