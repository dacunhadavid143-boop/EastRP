/* Banque : carte */
PHN_bTab = 2;
[PHN_rBg] call PHN_fnc_uiAppBg;
private _c = PHN_C;
private _my = player getVariable ["PHN_number", "0000000"];
[0.05, 0.012, 0.8, 0.065, "Carte", 0.050, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;

private _cw = 0.88;
private _ch = ([_cw] call PHN_fnc_squareH) / 1.586;
[0.06, 0.12, _cw, _ch, [0.20,0.22,0.27,1], 18, [0.04,0.05,0.08,1]] call PHN_fnc_uiRect;
[0.10, 0.12 + _ch * 0.10, 0.5, 0.04, "Carte virtuelle", 0.024, [1,1,1,0.7]] call PHN_fnc_uiText;
[0.60, 0.12 + _ch * 0.10, 0.30, 0.04, "DÉBIT", 0.024, [1,1,1,0.7], "right", "PuristaBold"] call PHN_fnc_uiText;
[0.10, 0.12 + _ch * 0.46, 0.8, 0.05, format ["**** **** **** %1", _my select [3, 4]], 0.040, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
[0.10, 0.12 + _ch * 0.76, 0.6, 0.04, toUpper (name player), 0.024, [1,1,1,0.9], "left", "PuristaBold"] call PHN_fnc_uiText;
[0.66, 0.12 + _ch * 0.76, 0.24, 0.04, "12/30", 0.024, [1,1,1,0.9], "right"] call PHN_fnc_uiText;

private _y = 0.12 + _ch + 0.05;
[0.05, _y, 0.9, 0.04, "Cette carte est liée à votre compte. Les paiements en magasin utiliseront", 0.020, [1,1,1,0.5]] call PHN_fnc_uiText;
[0.05, _y + 0.035, 0.9, 0.04, "directement le solde de votre compte bancaire.", 0.020, [1,1,1,0.5]] call PHN_fnc_uiText;

[["Accueil", "Paiements", "Carte"], 2, { [[PHN_fnc_pgBank, PHN_fnc_pgBankPay, PHN_fnc_pgBankCard] select (_this select 0), []] call PHN_fnc_showPage; }, PHN_rBg, [1,1,1,1], [1,1,1,0.45]] call PHN_fnc_uiTabBar;
