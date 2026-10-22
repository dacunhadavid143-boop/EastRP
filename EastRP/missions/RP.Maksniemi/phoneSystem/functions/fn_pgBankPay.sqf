/* Banque : paiements (virement vers un autre joueur) */
PHN_bTab = 1;
[PHN_rBg] call PHN_fnc_uiAppBg;
private _c = PHN_C;
private _sym = getText (missionConfigFile >> "CORE_Settings" >> "currencySymbol");
[0.05, 0.012, 0.8, 0.065, "Envoyer", 0.050, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
[0.05, 0.075, 0.9, 0.035, format ["Solde disponible : %1 %2", [player getVariable ["CORE_bank", 0]] call CORE_fnc_fmt, _sym], 0.022, [1,1,1,0.55]] call PHN_fnc_uiText;

private _others = allPlayers select { _x != player && {alive _x} };
if (isNull PHN_targetObj || {!(PHN_targetObj in _others)}) then { PHN_targetObj = objNull; };
[0.05, 0.13, 0.9, 0.035, "À qui voulez-vous envoyer de l'argent ?", 0.022, [1,1,1,0.55]] call PHN_fnc_uiText;
private _y = 0.17;
{
    if (_forEachIndex < 5) then {
        private _sel = _x isEqualTo PHN_targetObj;
        [0.04, _y, 0.92, 0.085, if (_sel) then { PHN_rBlue } else { PHN_rCard }, 14] call PHN_fnc_uiRect;
        [0.06, _y + 0.012, 0.11, _forEachIndex, [name _x] call PHN_fnc_waInitials] call PHN_fnc_uiAvatar;
        [0.22, _y + 0.022, 0.70, 0.04, name _x, 0.028, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
        [0.04, _y, 0.92, 0.085, "", [0,0,0,0], [1,1,1,1], { PHN_targetObj = (allPlayers select { _x != player && {alive _x} }) select (_this select 0); [] call PHN_fnc_refresh; }, _forEachIndex, 14, 0.02] call PHN_fnc_uiButton;
        _y = _y + 0.095;
    };
} forEach _others;
if (_others isEqualTo []) then { [0.05, 0.25, 0.9, 0.04, "Aucun autre joueur en ligne.", 0.024, [1,1,1,0.45], "center"] call PHN_fnc_uiText; };

[0.05, 0.665, 0.5, 0.035, "Montant", 0.022, [1,1,1,0.55]] call PHN_fnc_uiText;
[0.05, 0.70, 0.9, 0.06, "", 0.034, "amount"] call PHN_fnc_uiEdit;
[0.05, 0.775, 0.9, 0.065, "Envoyer", PHN_rBlue, [1,1,1,1], {
    private _a = floor (parseNumber (ctrlText (PHN_refs getOrDefault ["amount", controlNull])));
    if (_a <= 0) exitWith { systemChat "[Banque] Saisissez un montant."; };
    if (isNull PHN_targetObj) exitWith { systemChat "[Banque] Choisissez un destinataire."; };
    [player, "transfer", _a, PHN_targetObj] remoteExec ["PHN_fnc_srvBank", 2];
    [] spawn { uiSleep 0.8; if (PHN_open) then { [PHN_fnc_pgBank, []] call PHN_fnc_showPage; }; };
}, [], 22, 0.03] call PHN_fnc_uiButton;

[["Accueil", "Paiements", "Carte"], 1, { [[PHN_fnc_pgBank, PHN_fnc_pgBankPay, PHN_fnc_pgBankCard] select (_this select 0), []] call PHN_fnc_showPage; }, PHN_rBg, [1,1,1,1], [1,1,1,0.45]] call PHN_fnc_uiTabBar;
