/* Chat : onglet Statuts */
PHN_waTab = 0;
[PHN_wBg] call PHN_fnc_uiAppBg;
private _c = PHN_C;
[0.05, 0.012, 0.8, 0.065, "Statuts", 0.050, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;

private _my = player getVariable ["PHN_number", ""];
private _all = player getVariable ["PHN_waStatus", []];
private _mine = _all select { (_x select 0) == _my };
private _mp = [_my] call PHN_fnc_waProfileOf;

// Mon statut
[0.04, 0.105, 0.14, if (_mp isEqualTo []) then { 0 } else { _mp select 1 }, [if (_mp isEqualTo []) then { "?" } else { _mp select 0 }] call PHN_fnc_waInitials, _mine isNotEqualTo []] call PHN_fnc_uiAvatar;
[0.23, 0.108, 0.70, 0.04, "Mon statut", 0.030, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
[0.23, 0.150, 0.70, 0.035, if (_mine isEqualTo []) then { "Touchez pour ajouter un statut" } else { format ["Publié %1 - touchez pour modifier", [(_mine select 0) select 3] call PHN_fnc_waTimeLabel] }, 0.022, PHN_wGray] call PHN_fnc_uiText;
[0.0, 0.098, 1, 0.095, "", [0,0,0,0], [1,1,1,1], { [PHN_fnc_pgWaStatusNew, []] call PHN_fnc_showPage; }, [], 0, 0.02] call PHN_fnc_uiButton;

[0.05, 0.225, 0.9, 0.035, "Mises à jour récentes", 0.022, PHN_wGray] call PHN_fnc_uiText;
private _others = _all select { (_x select 0) != _my };
private _y = 0.265;
{
    if (_forEachIndex < 6) then {
        _x params ["_num", "_txt", "_col", "_t"];
        private _p = [_num] call PHN_fnc_waProfileOf;
        private _name = [_num] call PHN_fnc_waName;
        [0.04, _y + 0.008, 0.14, if (_p isEqualTo []) then { 6 } else { _p select 1 }, [_name] call PHN_fnc_waInitials, true] call PHN_fnc_uiAvatar;
        [0.23, _y + 0.012, 0.70, 0.04, _name, 0.030, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
        [0.23, _y + 0.054, 0.70, 0.035, [_t] call PHN_fnc_waTimeLabel, 0.022, PHN_wGray] call PHN_fnc_uiText;
        [0.0, _y, 1, 0.098, "", [0,0,0,0], [1,1,1,1], { [PHN_fnc_pgWaStatusView, [_this select 0]] call PHN_fnc_showPage; }, _num, 0, 0.02] call PHN_fnc_uiButton;
        _y = _y + 0.106;
    };
} forEach _others;
if (_others isEqualTo []) then { [0.05, 0.40, 0.9, 0.04, "Aucune mise à jour récente.", 0.024, PHN_wGray, "center"] call PHN_fnc_uiText; };

[["Statuts", "Discussions", "Vous"], 0, { [[PHN_fnc_pgWaStatus, PHN_fnc_pgWaChats, PHN_fnc_pgWaYou] select (_this select 0), []] call PHN_fnc_showPage; }] call PHN_fnc_uiTabBar;
