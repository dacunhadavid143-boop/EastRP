/* CLIENT : construit la fenêtre du Pôle Emploi (emploi actuel, démission, liste des métiers). params: [display] */
disableSerialization;
params ["_d"];
private _mk = {
    params ["_cls", "_px", "_py", "_pw", "_ph"];
    private _c = _d ctrlCreate [_cls, -1];
    _c ctrlSetPosition [_px, _py, _pw, _ph];
    _c ctrlCommit 0;
    _c
};
private _s = player getVariable ["JOB_state", []];
if (count _s == 0) then { _s = ["", 0, "", 0, -1, 0, "", "", false, 0, 14400, [], 0, "", 0, 0, "", 0]; };
private _job = _s select 0;
private _xpList = _s select 11;
private _jobs = "true" configClasses (missionConfigFile >> "JOB_Jobs");
private _xpOf = { params ["_id"]; private _i = _xpList findIf { _x isEqualType [] && {(_x select 0) == _id} }; if (_i < 0) then { 0 } else { (_xpList select _i) select 1 } };

private _w = 0.70;
private _h = 0.30 + (count _jobs) * 0.105;
private _x0 = safeZoneX + safeZoneW / 2 - _w / 2;
private _y0 = safeZoneY + safeZoneH / 2 - _h / 2;

private _bg = ["JOB_RscText", _x0, _y0, _w, _h] call _mk;
_bg ctrlSetBackgroundColor [0.05, 0.06, 0.08, 0.94];
private _ln = ["JOB_RscText", _x0, _y0, _w, 0.006] call _mk;
_ln ctrlSetBackgroundColor [0.95, 0.55, 0.12, 1];
private _t = ["JOB_RscText", _x0 + 0.02, _y0 + 0.018, _w - 0.04, 0.05] call _mk;
_t ctrlSetFont "PuristaBold"; _t ctrlSetFontHeight 0.05; _t ctrlSetText "Pôle Emploi";

// Situation actuelle
private _l1 = ["JOB_RscText", _x0 + 0.02, _y0 + 0.08, _w - 0.24, 0.04] call _mk;
private _l2 = ["JOB_RscText", _x0 + 0.02, _y0 + 0.12, _w - 0.24, 0.04] call _mk;
_l2 ctrlSetFontHeight 0.03; _l2 ctrlSetTextColor [1, 1, 1, 0.65];
if (_job == "") then {
    _l1 ctrlSetText "Situation : sans emploi";
    _l2 ctrlSetText (if ((_s select 12) > 0) then { format ["Nouvelle inscription possible dans %1", [(_s select 12) * 60] call JOB_fnc_fmtDur] } else { "Choisissez un métier ci-dessous pour signer un contrat." });
} else {
    _l1 ctrlSetText format ["Emploi : %1 - %2 (niveau %3)", _s select 16, _s select 2, _s select 1];
    private _left = (_s select 10) - (_s select 9);
    _l2 ctrlSetText (if (_left > 0) then { format ["Contrat : %1 / %2 de travail effectués", [_s select 9] call JOB_fnc_fmtDur, [_s select 10] call JOB_fnc_fmtDur] } else { "Contrat minimum effectué : démission possible." });
    private _bq = ["JOB_RscButton", _x0 + _w - 0.20, _y0 + 0.085, 0.18, 0.06] call _mk;
    _bq ctrlSetText "Démissionner";
    _bq ctrlSetBackgroundColor [0.75, 0.20, 0.18, 1];
    _bq ctrlEnable (_left <= 0);
    _bq ctrlAddEventHandler ["ButtonClick", { [player] remoteExec ["JOB_fnc_srvQuit", 2]; closeDialog 0; }];
};

// Liste des métiers
private _lh = ["JOB_RscText", _x0 + 0.02, _y0 + 0.185, _w - 0.04, 0.035] call _mk;
_lh ctrlSetFontHeight 0.03; _lh ctrlSetTextColor [0.95, 0.55, 0.12, 1]; _lh ctrlSetText "MÉTIERS DISPONIBLES (sans diplôme)";
{
    private _id = configName _x;
    private _xp = [_id] call _xpOf;
    private _lv = [_id, _xp] call JOB_fnc_cfgLevel;
    private _yy = _y0 + 0.23 + _forEachIndex * 0.105;
    private _row = ["JOB_RscText", _x0 + 0.02, _yy, _w - 0.04, 0.095] call _mk;
    _row ctrlSetBackgroundColor (if (_id == _job) then { [0.95, 0.55, 0.12, 0.18] } else { [1, 1, 1, 0.07] });
    private _n = ["JOB_RscText", _x0 + 0.035, _yy + 0.008, _w - 0.25, 0.04] call _mk;
    _n ctrlSetFont "PuristaBold"; _n ctrlSetText getText (_x >> "displayName");
    private _sub = ["JOB_RscText", _x0 + 0.035, _yy + 0.048, _w - 0.25, 0.035] call _mk;
    _sub ctrlSetFontHeight 0.028; _sub ctrlSetTextColor [1, 1, 1, 0.65];
    _sub ctrlSetText format ["Votre niveau : %1 - %2 (%3 XP)", _lv select 0, getText ((_lv select 1) >> "title"), _xp];
    private _b = ["JOB_RscButton", _x0 + _w - 0.20, _yy + 0.02, 0.165, 0.055] call _mk;
    _b ctrlSetText (if (_id == _job) then { "Votre emploi" } else { "Signer" });
    _b ctrlEnable (_job == "" && {(_s select 12) <= 0});
    if (_job == "") then { _b ctrlSetBackgroundColor [0.15, 0.55, 0.30, 1]; };
    _b setVariable ["JOB_id", _id];
    _b ctrlAddEventHandler ["ButtonClick", { params ["_c"]; [player, _c getVariable "JOB_id"] remoteExec ["JOB_fnc_srvSign", 2]; closeDialog 0; }];
} forEach _jobs;

private _close = ["JOB_RscButton", _x0 + _w - 0.17, _y0 + _h - 0.065, 0.15, 0.05] call _mk;
_close ctrlSetText "Fermer";
_close ctrlAddEventHandler ["ButtonClick", { closeDialog 0; }];
