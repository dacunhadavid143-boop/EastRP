/* Chat : création / modification du profil. params: ["new"|"edit"] */
params [["_mode", "new"]];
[PHN_wBg] call PHN_fnc_uiAppBg;
[0, 0.012, 1, 0.05, if (_mode == "new") then { "Infos du profil" } else { "Modifier le profil" }, 0.034, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
[0.02, 0.012, 0.3, 0.05, "< Retour", [0,0,0,0], PHN_wGreen, {
    params ["_m"];
    if (_m == "new") then { [PHN_fnc_pgWaNumber, []] call PHN_fnc_showPage; } else { [PHN_fnc_pgWaYou, []] call PHN_fnc_showPage; };
}, _mode, 0, 0.028] call PHN_fnc_uiButton;

private _fw = 0.30;
private _fh = [_fw] call PHN_fnc_squareH;
[0.35, 0.09, _fw, PHN_waTmp select 2, [PHN_waTmp select 1] call PHN_fnc_waInitials] call PHN_fnc_uiAvatar;
[0.35, 0.09, _fw, _fh, "", [0,0,0,0], [1,1,1,1], {
    [] call PHN_fnc_waTmpRead;
    PHN_waTmp set [2, ((PHN_waTmp select 2) + 1) mod 8];
    [] call PHN_fnc_refresh;
}, [], 0, 0.02] call PHN_fnc_uiButton;
[0.05, 0.09 + _fh + 0.012, 0.9, 0.035, "Touchez l'avatar pour changer de couleur", 0.021, PHN_wGray, "center"] call PHN_fnc_uiText;

private _y = 0.09 + _fh + 0.075;
[0.06, _y, 0.88, 0.035, "Nom", 0.022, PHN_wGray] call PHN_fnc_uiText;
[0.06, _y + 0.035, 0.88, 0.065, PHN_waTmp select 1, 0.034, "name"] call PHN_fnc_uiEdit;
[0.06, _y + 0.13, 0.88, 0.035, "Info", 0.022, PHN_wGray] call PHN_fnc_uiText;
[0.06, _y + 0.165, 0.88, 0.065, PHN_waTmp select 3, 0.030, "about"] call PHN_fnc_uiEdit;
private _err = [0.06, _y + 0.24, 0.88, 0.04, "", 0.024, [0.95,0.35,0.35,1]] call PHN_fnc_uiText;
PHN_refs set ["err", _err];
[0.06, _y + 0.30, 0.88, 0.065, if (_mode == "new") then { "Terminer" } else { "Enregistrer" }, PHN_wGreen, [0.04, 0.08, 0.10, 1], {
    params ["_m"];
    [] call PHN_fnc_waTmpRead;
    private _t = PHN_waTmp;
    if (((_t select 1) splitString " ") isEqualTo []) exitWith { (PHN_refs get "err") ctrlSetText "Saisissez un nom."; };
    if (_m == "new") then {
        [player, _t select 0, _t select 1, _t select 2, _t select 3] remoteExec ["PHN_fnc_srvWaRegister", 2];
    } else {
        [player, _t select 1, _t select 2, _t select 3] remoteExec ["PHN_fnc_srvWaProfile", 2];
    };
    [_m] spawn {
        params ["_m"];
        uiSleep 0.9;
        if (!PHN_open) exitWith {};
        if (_m == "new") then { PHN_waTab = 1; [PHN_fnc_pgWa, []] call PHN_fnc_showPage; } else { [PHN_fnc_pgWaYou, []] call PHN_fnc_showPage; };
    };
}, _mode, 20, 0.03] call PHN_fnc_uiButton;
