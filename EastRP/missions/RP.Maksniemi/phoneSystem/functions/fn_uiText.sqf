/* Texte dans la page. params: [fx, fy, fw, fh, texte, taille (fraction de la hauteur de contenu), couleur, alignement "left"|"center"|"right", police]. Renvoie le contrôle. */
params ["_fx", "_fy", "_fw", "_fh", "_txt", ["_size", 0.03], ["_col", [1,1,1,1]], ["_align", "left"], ["_font", "PuristaMedium"]];
private _c = PHN_C;
private _cls = switch (_align) do { case "center": {"PHN_RscTextC"}; case "right": {"PHN_RscTextR"}; default {"PHN_RscText"} };
private _t = (uiNamespace getVariable "PHN_display") ctrlCreate [_cls, -1];
_t ctrlSetPosition [(_c select 0) + _fx * (_c select 2), (_c select 1) + _fy * (_c select 3), _fw * (_c select 2), _fh * (_c select 3)];
_t ctrlSetFont _font;
_t ctrlSetFontHeight (_size * (_c select 3));
_t ctrlSetTextColor _col;
_t ctrlSetText _txt;
_t ctrlCommit 0;
PHN_page pushBack _t;
_t
