/* Bouton arrondi. params: [fx, fy, fw, fh, texte, couleurFond, couleurTexte, code, donnée, rayonPx, taille]. Le code reçoit [donnée]. Renvoie le contrôle bouton. */
params ["_fx", "_fy", "_fw", "_fh", "_txt", ["_bg", [0.2,0.2,0.22,1]], ["_fg", [1,1,1,1]], ["_code", {}], ["_data", []], ["_r", 10], ["_size", 0.03]];
private _c = PHN_C;
private _ax = (_c select 0) + _fx * (_c select 2);
private _ay = (_c select 1) + _fy * (_c select 3);
private _aw = _fw * (_c select 2);
private _ah = _fh * (_c select 3);
if ((_bg select 3) > 0) then { PHN_page append ([_ax, _ay, _aw, _ah, _r, _bg] call PHN_fnc_roundRect); };
private _b = (uiNamespace getVariable "PHN_display") ctrlCreate ["PHN_RscButtonFlat", -1];
_b ctrlSetPosition [_ax, _ay, _aw, _ah];
_b ctrlSetFont "PuristaMedium";
_b ctrlSetFontHeight (_size * (_c select 3));
_b ctrlSetTextColor _fg;
_b ctrlSetText _txt;
_b setVariable ["PHN_code", _code];
_b setVariable ["PHN_data", _data];
_b ctrlAddEventHandler ["ButtonClick", { params ["_ctl"]; [_ctl getVariable "PHN_data"] call (_ctl getVariable "PHN_code"); }];
_b ctrlCommit 0;
PHN_page pushBack _b;
_b
