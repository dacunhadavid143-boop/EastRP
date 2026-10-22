/* Banque : accueil (solde, actions, transactions) */
PHN_bTab = 0;
[PHN_rBg] call PHN_fnc_uiAppBg;
private _c = PHN_C;
private _sym = getText (missionConfigFile >> "CORE_Settings" >> "currencySymbol");
private _bank = player getVariable ["CORE_bank", 0];
private _first = ((name player splitString " ") select { _x != "" }) param [0, "vous"];

[0.04, 0.014, 0.11, 0, [name player] call PHN_fnc_waInitials] call PHN_fnc_uiAvatar;
[0.19, 0.024, 0.70, 0.04, format ["Bonjour, %1", _first], 0.026, [1,1,1,0.75]] call PHN_fnc_uiText;

[0, 0.115, 1, 0.12, format ["%1 %2", [_bank] call CORE_fnc_fmt, _sym], 0.085, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
[0.31, 0.245, 0.38, 0.05, PHN_rCard, 14] call PHN_fnc_uiRect;
[0.31, 0.253, 0.38, 0.04, "Compte personnel", 0.021, [1,1,1,0.85], "center"] call PHN_fnc_uiText;

// Actions rondes
private _bw = 0.17;
private _bh = [_bw] call PHN_fnc_squareH;
private _acts = [["send", "Envoyer", PHN_fnc_pgBankPay], ["card", "Carte", PHN_fnc_pgBankCard], ["info", "Détails", PHN_fnc_pgBankDetails]];
{
    _x params ["_k", "_lbl", "_pg"];
    private _fx = 0.10 + _forEachIndex * 0.29;
    [_fx, 0.33, _bw, _bh, PHN_rCard, 0.5 * (_bw * (_c select 2)) / pixelW, [], 14] call PHN_fnc_uiRect;
    [_k, (_c select 0) + _fx * (_c select 2), (_c select 1) + 0.33 * (_c select 3), _bw * (_c select 2), _bh * (_c select 3), [1,1,1,1]] call PHN_fnc_uiPict;
    [_fx - 0.04, 0.33 + _bh + 0.008, _bw + 0.08, 0.035, _lbl, 0.021, [1,1,1,0.85], "center"] call PHN_fnc_uiText;
    [_fx, 0.33, _bw, _bh + 0.045, "", [0,0,0,0], [1,1,1,1], { [_this select 0, []] call PHN_fnc_showPage; }, _pg, 0, 0.02] call PHN_fnc_uiButton;
} forEach _acts;

// Transactions
[0.05, 0.54, 0.6, 0.045, "Transactions", 0.034, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
private _log = player getVariable ["CORE_bankLog", []];
if !(_log isEqualType []) then { diag_log format ["[PHN] journal bancaire invalide : %1", _log]; _log = []; };
private _y = 0.60;
private _total = count _log;
private _shown = 0;
// les 5 dernières transactions, la plus récente en haut ; index toujours dans les limites, lignes mal formées ignorées
for "_k" from 1 to (5 min _total) do {
    private _e = _log select (_total - _k);
    if (_e isEqualType [] && {count _e >= 3} && {(_e select 1) isEqualType ""} && {(_e select 2) isEqualType 0}) then {
        private _when = _e select 0;
        if !(_when isEqualType "") then { _when = ""; };
        private _txt = _e select 1;
        private _amt = _e select 2;
        [0.04, _y + 0.004, 0.10, if (_amt >= 0) then { 4 } else { 1 }, ([_txt] call PHN_fnc_waInitials) select [0, 1]] call PHN_fnc_uiAvatar;
        [0.19, _y + 0.003, 0.50, 0.035, _txt, 0.026, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
        [0.19, _y + 0.037, 0.50, 0.03, _when, 0.019, [1,1,1,0.5]] call PHN_fnc_uiText;
        [0.55, _y + 0.012, 0.41, 0.04, format ["%1%2 %3", if (_amt >= 0) then { "+" } else { "" }, [_amt] call CORE_fnc_fmt, _sym], 0.026, if (_amt >= 0) then { PHN_rGreen } else { [1,1,1,1] }, "right", "PuristaBold"] call PHN_fnc_uiText;
        _y = _y + 0.060;
        _shown = _shown + 1;
    } else {
        diag_log format ["[PHN] ligne de journal bancaire ignorée : %1", _e];
    };
};
if (_shown == 0) then { [0.05, 0.64, 0.9, 0.04, "Aucune transaction", 0.024, [1,1,1,0.45], "center"] call PHN_fnc_uiText; };

[["Accueil", "Paiements", "Carte"], 0, { [[PHN_fnc_pgBank, PHN_fnc_pgBankPay, PHN_fnc_pgBankCard] select (_this select 0), []] call PHN_fnc_showPage; }, PHN_rBg, [1,1,1,1], [1,1,1,0.45]] call PHN_fnc_uiTabBar;
