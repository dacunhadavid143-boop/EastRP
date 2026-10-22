/* Dessine le pictogramme d'une application dans son icône. params: [id, x, y, w, h (absolus), couleur de l'appli, glyphe texte] */
params ["_id", "_ax", "_ay", "_aw", "_ah", "_col", ["_glyph", ""]];
private _dark = [(_col select 0) * 0.55, (_col select 1) * 0.55, (_col select 2) * 0.55, 1];
private _white = [1,1,1,1];
private _r = {
    params ["_fx", "_fy", "_fw", "_fh", "_rad", "_c"];
    PHN_page append ([_ax + _fx * _aw, _ay + _fy * _ah, _fw * _aw, _fh * _ah, _rad, _c] call PHN_fnc_roundRect);
};
switch (_id) do {
    case "phone": {
        [0.34, 0.20, 0.32, 0.60, 5, _white] call _r;
        [0.38, 0.27, 0.24, 0.40, 1, _dark] call _r;
        [0.46, 0.72, 0.08, 0.04, 2, _dark] call _r;
    };
    case "messages": {
        [0.18, 0.22, 0.64, 0.46, 12, _white] call _r;
        [0.26, 0.62, 0.12, 0.16, 1, _white] call _r;
        [0.30, 0.41, 0.08, 0.08, 4, _dark] call _r;
        [0.46, 0.41, 0.08, 0.08, 4, _dark] call _r;
        [0.62, 0.41, 0.08, 0.08, 4, _dark] call _r;
    };
    case "bank": {
        [0.16, 0.28, 0.68, 0.44, 6, _white] call _r;
        [0.16, 0.38, 0.68, 0.09, 0, _dark] call _r;
        [0.22, 0.58, 0.22, 0.06, 2, _dark] call _r;
    };
    case "settings": {
        [0.20, 0.28, 0.60, 0.07, 3, _white] call _r;
        [0.20, 0.47, 0.60, 0.07, 3, _white] call _r;
        [0.20, 0.66, 0.60, 0.07, 3, _white] call _r;
        [0.56, 0.23, 0.14, 0.17, 8, _dark] call _r;
        [0.30, 0.42, 0.14, 0.17, 8, _dark] call _r;
        [0.60, 0.61, 0.14, 0.17, 8, _dark] call _r;
    };
    case "admin": {
        [0.28, 0.18, 0.44, 0.60, 10, _white] call _r;
        [0.465, 0.28, 0.07, 0.28, 2, _dark] call _r;
        [0.465, 0.62, 0.07, 0.07, 3, _dark] call _r;
    };
    default {
        private _t = (uiNamespace getVariable "PHN_display") ctrlCreate ["PHN_RscTextC", -1];
        _t ctrlSetPosition [_ax, _ay + _ah * 0.18, _aw, _ah * 0.64];
        _t ctrlSetFont "PuristaBold";
        _t ctrlSetFontHeight (_ah * 0.5);
        _t ctrlSetText _glyph;
        _t ctrlCommit 0;
        PHN_page pushBack _t;
    };
};
