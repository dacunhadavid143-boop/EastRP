/* Chat : onglet Vous (profil) */
PHN_waTab = 2;
[PHN_wBg] call PHN_fnc_uiAppBg;
[0.05, 0.012, 0.8, 0.065, "Vous", 0.050, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
private _my = player getVariable ["PHN_number", ""];
private _p = [_my] call PHN_fnc_waProfileOf;
private _name = if (_p isEqualTo []) then { "?" } else { _p select 0 };
private _fw = 0.30;
private _fh = [_fw] call PHN_fnc_squareH;
[0.35, 0.11, _fw, if (_p isEqualTo []) then { 0 } else { _p select 1 }, [_name] call PHN_fnc_waInitials] call PHN_fnc_uiAvatar;
[0.05, 0.11 + _fh + 0.025, 0.9, 0.06, _name, 0.042, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
[0.05, 0.11 + _fh + 0.090, 0.9, 0.04, if (_p isEqualTo []) then { "" } else { _p select 2 }, 0.026, PHN_wGray, "center"] call PHN_fnc_uiText;
[0.05, 0.11 + _fh + 0.14, 0.9, 0.04, [_my] call PHN_fnc_fmtPhone, 0.028, PHN_wGray, "center"] call PHN_fnc_uiText;
[0.10, 0.11 + _fh + 0.22, 0.80, 0.065, "Modifier le profil", PHN_wPanel, [1,1,1,1], {
    private _q = [player getVariable ["PHN_number", ""]] call PHN_fnc_waProfileOf;
    PHN_waTmp = [player getVariable ["PHN_number", ""], if (_q isEqualTo []) then { "" } else { _q select 0 }, if (_q isEqualTo []) then { 0 } else { _q select 1 }, if (_q isEqualTo []) then { "Disponible" } else { _q select 2 }];
    [PHN_fnc_pgWaProfile, ["edit"]] call PHN_fnc_showPage;
}, [], 18, 0.028] call PHN_fnc_uiButton;
[["Statuts", "Discussions", "Vous"], 2, { [[PHN_fnc_pgWaStatus, PHN_fnc_pgWaChats, PHN_fnc_pgWaYou] select (_this select 0), []] call PHN_fnc_showPage; }] call PHN_fnc_uiTabBar;
