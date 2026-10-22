/* Champ de saisie. params: [fx, fy, fw, fh, texte, taille, cléDeRéférence]. Le contrôle est retrouvable avec PHN_refs get cléDeRéférence. */
params ["_fx", "_fy", "_fw", "_fh", ["_txt", ""], ["_size", 0.03], ["_key", ""]];
private _c = PHN_C;
private _ax = (_c select 0) + _fx * (_c select 2);
private _ay = (_c select 1) + _fy * (_c select 3);
private _aw = _fw * (_c select 2);
private _ah = _fh * (_c select 3);
PHN_page append ([_ax, _ay, _aw, _ah, 10, [1,1,1,0.16]] call PHN_fnc_roundRect);
private _e = (uiNamespace getVariable "PHN_display") ctrlCreate ["PHN_RscEdit", -1];
_e ctrlSetPosition [_ax + 0.008, _ay + _ah * 0.12, _aw - 0.016, _ah * 0.8];
_e ctrlSetFontHeight (_size * (_c select 3));
_e ctrlSetText _txt;
_e ctrlCommit 0;
PHN_page pushBack _e;
if (_key != "") then { PHN_refs set [_key, _e]; };
_e
