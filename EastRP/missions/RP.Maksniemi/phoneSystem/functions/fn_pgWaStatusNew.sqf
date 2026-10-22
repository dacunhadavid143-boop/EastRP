/* Chat : nouveau statut (texte sur fond coloré, valable 24 h) */
[PHN_wBg] call PHN_fnc_uiAppBg;
private _c = PHN_C;
private _my = player getVariable ["PHN_number", ""];
private _has = (player getVariable ["PHN_waStatus", []]) findIf { (_x select 0) == _my } >= 0;
[0, 0.012, 1, 0.05, "Nouveau statut", 0.034, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
[0.02, 0.012, 0.3, 0.05, "< Retour", [0,0,0,0], PHN_wGreen, { [PHN_fnc_pgWaStatus, []] call PHN_fnc_showPage; }, [], 0, 0.028] call PHN_fnc_uiButton;

// Aperçu
[0.05, 0.10, 0.9, 0.30, PHN_wStCols select PHN_waStCol, 16] call PHN_fnc_uiRect;
private _s = (uiNamespace getVariable "PHN_display") ctrlCreate ["PHN_RscStruct", -1];
_s ctrlSetPosition [(_c select 0) + 0.10 * (_c select 2), (_c select 1) + 0.12 * (_c select 3), 0.80 * (_c select 2), 0.26 * (_c select 3)];
_s ctrlSetStructuredText parseText format ["<t align='center' size='%2'>%1</t>", if (PHN_waStText == "") then { "Votre statut..." } else { [PHN_waStText] call PHN_fnc_esc }, (_c select 3) / 0.5];
_s ctrlCommit 0;
PHN_page pushBack _s;

// Couleurs
private _sw = 0.12;
private _sh = [_sw] call PHN_fnc_squareH;
{
    [0.06 + _forEachIndex * 0.155, 0.43, _sw, _sh, _x, 0.5 * (_sw * (_c select 2)) / pixelW, [], 14] call PHN_fnc_uiRect;
    [0.06 + _forEachIndex * 0.155, 0.43, _sw, _sh, "", [0,0,0,0], [1,1,1,1], {
        private _e = PHN_refs getOrDefault ["txt", controlNull];
        if (!isNull _e) then { PHN_waStText = ctrlText _e; };
        PHN_waStCol = _this select 0;
        [] call PHN_fnc_refresh;
    }, _forEachIndex, 0, 0.02] call PHN_fnc_uiButton;
} forEach PHN_wStCols;

[0.05, 0.43 + _sh + 0.03, 0.9, 0.035, "Texte (140 caractères max.)", 0.021, PHN_wGray] call PHN_fnc_uiText;
[0.05, 0.43 + _sh + 0.065, 0.9, 0.065, PHN_waStText, 0.030, "txt"] call PHN_fnc_uiEdit;
[0.05, 0.43 + _sh + 0.16, 0.9, 0.065, "Publier", PHN_wGreen, [0.04, 0.08, 0.10, 1], {
    private _t = ctrlText (PHN_refs getOrDefault ["txt", controlNull]);
    if ((_t splitString " ") isEqualTo []) exitWith { systemChat "[Chat] Saisissez un texte."; };
    [player, _t, PHN_waStCol] remoteExec ["PHN_fnc_srvWaStatusPost", 2];
    PHN_waStText = "";
    [] spawn { uiSleep 0.7; if (PHN_open) then { [PHN_fnc_pgWaStatus, []] call PHN_fnc_showPage; }; };
}, [], 20, 0.03] call PHN_fnc_uiButton;
if (_has) then {
    [0.05, 0.43 + _sh + 0.245, 0.9, 0.055, "Supprimer mon statut", [0.80,0.20,0.20,1], [1,1,1,1], {
        [player] remoteExec ["PHN_fnc_srvWaStatusDel", 2];
        [] spawn { uiSleep 0.7; if (PHN_open) then { [PHN_fnc_pgWaStatus, []] call PHN_fnc_showPage; }; };
    }, [], 18, 0.026] call PHN_fnc_uiButton;
};
