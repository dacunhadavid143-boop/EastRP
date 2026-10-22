/* Écran d'appel (entrant / sortant / en cours) */
private _st = PHN_call select 0;
if (_st == "idle") exitWith { [PHN_fnc_pgDialer, []] call PHN_fnc_showPage; };
PHN_onCallPage = true;
private _num = if (count PHN_call > 1) then { PHN_call select 1 } else { "" };
private _c = PHN_C;
private _fw = 0.30;
private _fh = [_fw] call PHN_fnc_squareH;
[0.35, 0.10, _fw, _fh, [1,1,1,0.2], 0.5 * (_fw * (_c select 2)) / pixelW] call PHN_fnc_uiRect;
[0.35, 0.10 + _fh * 0.28, _fw, _fh * 0.5, "TEL", 0.05, [1,1,1,0.85], "center", "PuristaBold"] call PHN_fnc_uiText;
[0, 0.10 + _fh + 0.03, 1, 0.06, [_num] call PHN_fnc_fmtPhone, 0.05, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;

private _bh = [0.26] call PHN_fnc_squareH;
private _brad = 0.5 * (0.26 * (_c select 2)) / pixelW;
private _by = 0.78;
switch (_st) do {
    case "incoming": {
        [0, 0.10 + _fh + 0.10, 1, 0.04, "Appel entrant...", 0.028, [1,1,1,0.7], "center"] call PHN_fnc_uiText;
        [0.14, _by, 0.26, _bh, "Refuser", [0.88,0.25,0.25,1], [1,1,1,1], { [player, false] remoteExec ["PHN_fnc_srvCallAnswer", 2]; }, [], _brad, 0.024] call PHN_fnc_uiButton;
        [0.60, _by, 0.26, _bh, "Répondre", [0.20,0.78,0.35,1], [1,1,1,1], { [player, true] remoteExec ["PHN_fnc_srvCallAnswer", 2]; }, [], _brad, 0.024] call PHN_fnc_uiButton;
    };
    case "ringing": {
        [0, 0.10 + _fh + 0.10, 1, 0.04, "Appel en cours...", 0.028, [1,1,1,0.7], "center"] call PHN_fnc_uiText;
        [0.37, _by, 0.26, _bh, "Annuler", [0.88,0.25,0.25,1], [1,1,1,1], { [player] remoteExec ["PHN_fnc_srvCallEnd", 2]; }, [], _brad, 0.024] call PHN_fnc_uiButton;
    };
    case "active": {
        private _t = [0, 0.10 + _fh + 0.10, 1, 0.05, "00:00", 0.04, [1,1,1,0.85], "center"] call PHN_fnc_uiText;
        PHN_refs set ["callTimer", _t];
        [0.05, 0.10 + _fh + 0.19, 0.9, 0.08, "Parlez avec votre touche de voix (VON) : canal « Appel » sélectionné.", 0.022, [1,1,1,0.55], "center"] call PHN_fnc_uiText;
        [0.37, _by, 0.26, _bh, "Raccrocher", [0.88,0.25,0.25,1], [1,1,1,1], { [player] remoteExec ["PHN_fnc_srvCallEnd", 2]; }, [], _brad, 0.022] call PHN_fnc_uiButton;
    };
};
