/* Chat : saisie du numéro de téléphone */
[PHN_wBg] call PHN_fnc_uiAppBg;
[0, 0.012, 1, 0.05, "Votre numéro", 0.034, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
[0.02, 0.012, 0.3, 0.05, "< Retour", [0,0,0,0], PHN_wGreen, { [PHN_fnc_pgWaWelcome, []] call PHN_fnc_showPage; }, [], 0, 0.028] call PHN_fnc_uiButton;
[0.06, 0.12, 0.88, 0.04, "Saisissez le numéro de ce téléphone", 0.028, [1,1,1,1], "center"] call PHN_fnc_uiText;
[0.06, 0.165, 0.88, 0.04, "(il est affiché dans Réglages)", 0.022, PHN_wGray, "center"] call PHN_fnc_uiText;
[0.06, 0.27, 0.88, 0.035, "Numéro de téléphone", 0.022, PHN_wGray] call PHN_fnc_uiText;
[0.06, 0.305, 0.88, 0.07, PHN_waTmp select 0, 0.038, "num"] call PHN_fnc_uiEdit;
private _err = [0.06, 0.39, 0.88, 0.04, "", 0.024, [0.95,0.35,0.35,1]] call PHN_fnc_uiText;
PHN_refs set ["err", _err];
[0.06, 0.50, 0.88, 0.065, "Suivant", PHN_wGreen, [0.04, 0.08, 0.10, 1], {
    private _n = ctrlText (PHN_refs getOrDefault ["num", controlNull]);
    if (_n != (player getVariable ["PHN_number", ""])) exitWith { (PHN_refs get "err") ctrlSetText "Ce numéro ne correspond pas à votre téléphone."; };
    PHN_waTmp set [0, _n];
    if ((PHN_waTmp select 1) == "") then {
        private _w = (name player splitString " ") select { _x != "" };
        PHN_waTmp set [1, if (_w isEqualTo []) then { "" } else { _w select 0 }];
    };
    [PHN_fnc_pgWaProfile, ["new"]] call PHN_fnc_showPage;
}, [], 20, 0.03] call PHN_fnc_uiButton;
