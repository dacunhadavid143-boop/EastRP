/* Chat : écran d'accueil de la première connexion */
[PHN_wBg] call PHN_fnc_uiAppBg;
private _c = PHN_C;
private _fw = 0.32;
private _fh = [_fw] call PHN_fnc_squareH;
["messages", (_c select 0) + 0.34 * (_c select 2), (_c select 1) + 0.10 * (_c select 3), _fw * (_c select 2), _fh * (_c select 3), PHN_wGreen, ""] call PHN_fnc_uiAppIcon;
private _y = 0.10 + _fh + 0.06;
[0.05, _y, 0.9, 0.06, format ["Bienvenue sur %1", ["messages"] call PHN_fnc_appName], 0.046, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
[0.08, _y + 0.10, 0.84, 0.04, "Discutez avec les autres joueurs,", 0.027, PHN_wGray, "center"] call PHN_fnc_uiText;
[0.08, _y + 0.14, 0.84, 0.04, "publiez des statuts et gardez le contact.", 0.027, PHN_wGray, "center"] call PHN_fnc_uiText;
[0.08, 0.80, 0.84, 0.065, "Accepter et continuer", PHN_wGreen, [0.04, 0.08, 0.10, 1], { [PHN_fnc_pgWaNumber, []] call PHN_fnc_showPage; }, [], 20, 0.03] call PHN_fnc_uiButton;
