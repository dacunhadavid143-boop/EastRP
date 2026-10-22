/* Banque : détails du compte */
[PHN_rBg] call PHN_fnc_uiAppBg;
private _my = player getVariable ["PHN_number", "0000000"];
private _name = getText (missionConfigFile >> "CORE_Settings" >> "currencyName");
[0, 0.012, 1, 0.05, "Détails du compte", 0.034, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
[0.02, 0.012, 0.3, 0.05, "< Retour", [0,0,0,0], [0.35,0.65,1,1], { [PHN_fnc_pgBank, []] call PHN_fnc_showPage; }, [], 0, 0.028] call PHN_fnc_uiButton;
private _rows = [
    ["Titulaire", toUpper (name player)],
    ["Numéro de compte", format ["NR00 %1 %2", _my select [0, 3], _my select [3, 4]]],
    ["Type de compte", "Compte personnel"],
    ["Devise", _name]
];
private _y = 0.11;
{
    [0.04, _y, 0.92, 0.095, PHN_rCard, 14] call PHN_fnc_uiRect;
    [0.07, _y + 0.012, 0.86, 0.035, _x select 0, 0.021, [1,1,1,0.5]] call PHN_fnc_uiText;
    [0.07, _y + 0.046, 0.86, 0.04, _x select 1, 0.028, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
    _y = _y + 0.108;
} forEach _rows;
