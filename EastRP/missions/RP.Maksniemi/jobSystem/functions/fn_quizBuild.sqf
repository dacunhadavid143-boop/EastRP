/* CLIENT : construit la fenêtre du mini-jeu (onLoad de JOB_Quiz) à partir de JOB_quizData = [titre, texte, réponses, lignes de fiche].
   Avec des lignes de fiche : schéma de la pompe à gauche, tableau tolérances / mesures à droite (contrôle qualité). */
disableSerialization;
params ["_d"];
JOB_quizData params ["_title", "_txt", "_ans", ["_rows", []]];
private _n = count _ans;
private _fiche = count _rows > 0;
private _w = if (_fiche) then { 1.30 } else { 0.74 };
private _h = if (_fiche) then { 0.86 } else { 0.30 + 0.065 * _n };
private _x0 = 0.5 - _w / 2;
private _y0 = 0.5 - _h / 2;
private _mk = {
    params ["_cls", "_pos"];
    private _c = _d ctrlCreate [_cls, -1];
    _c ctrlSetPosition _pos;
    _c ctrlCommit 0;
    _c
};
private _bg = ["JOB_RscText", [_x0, _y0, _w, _h]] call _mk;
_bg ctrlSetBackgroundColor [0.08, 0.09, 0.11, 0.97];
private _bar = ["JOB_RscText", [_x0, _y0, _w, 0.006]] call _mk;
_bar ctrlSetBackgroundColor [0.95, 0.55, 0.12, 1];
private _t = ["JOB_RscText", [_x0 + 0.02, _y0 + 0.018, _w - 0.04, 0.045]] call _mk;
_t ctrlSetText toUpper _title;
_t ctrlSetTextColor [0.95, 0.55, 0.12, 1];
if (_fiche) then {
    // Schéma (image carrée) à gauche
    private _ph = 0.60;
    private _pw = _ph * 3 / 4;   // compense l'écran 4:3 de l'interface
    private _pic = ["JOB_RscPicture", [_x0 + 0.02, _y0 + 0.08, _pw, _ph]] call _mk;
    _pic ctrlSetText "\eastrp_core\data\fiche_pompe_co.paa";
    // Tableau à droite
    private _tx = _x0 + 0.05 + _pw;
    private _tw = _w - (_tx - _x0) - 0.02;
    private _hd = ["JOB_RscStructured", [_tx, _y0 + 0.08, _tw, 0.05]] call _mk;
    _hd ctrlSetStructuredText parseText "<t color='#9aa0a8' size='0.85'>CONTRÔLE</t><t color='#9aa0a8' size='0.85' align='right'>TOLÉRANCE   |   MESURE</t>";
    {
        _x params ["_lab", "_tol", "_mes"];
        private _yy = _y0 + 0.14 + 0.075 * _forEachIndex;
        private _rbg = ["JOB_RscText", [_tx, _yy, _tw, 0.065]] call _mk;
        _rbg ctrlSetBackgroundColor ([[0.13, 0.14, 0.17, 1], [0.16, 0.17, 0.20, 1]] select (_forEachIndex % 2));
        private _r = ["JOB_RscStructured", [_tx + 0.01, _yy + 0.008, _tw - 0.02, 0.055]] call _mk;
        _r ctrlSetStructuredText parseText format ["<t size='0.95'>%1</t><t align='right' size='0.95'><t color='#9aa0a8'>%2</t>   |   <t color='#ffd060'>%3</t></t>", _lab, _tol, _mes];
    } forEach _rows;
    private _q = ["JOB_RscStructured", [_tx, _y0 + 0.53, _tw, 0.08]] call _mk;
    _q ctrlSetStructuredText parseText format ["<t size='0.9' color='#c8ccd2'>%1</t>", _txt];
    {
        private _b = ["JOB_RscButton", [_x0 + 0.02 + (_w - 0.04) / 2 * _forEachIndex + 0.01, _y0 + _h - 0.11, (_w - 0.04) / 2 - 0.02, 0.07]] call _mk;
        _b ctrlSetText _x;
        _b ctrlSetBackgroundColor ([[0.15, 0.45, 0.20, 1], [0.55, 0.15, 0.15, 1]] select (_forEachIndex min 1));
        _b ctrlAddEventHandler ["ButtonClick", format ["JOB_quizRes = %1; closeDialog 0;", _forEachIndex]];
    } forEach _ans;
} else {
    private _q = ["JOB_RscStructured", [_x0 + 0.02, _y0 + 0.07, _w - 0.04, 0.16]] call _mk;
    _q ctrlSetStructuredText parseText format ["<t size='1.05'>%1</t><br/><br/><t color='#9aa0a8' size='0.9'>Quelle est votre conclusion ?</t>", _txt];
    {
        private _b = ["JOB_RscButton", [_x0 + 0.04, _y0 + 0.25 + 0.065 * _forEachIndex, _w - 0.08, 0.052]] call _mk;
        _b ctrlSetText _x;
        _b ctrlAddEventHandler ["ButtonClick", format ["JOB_quizRes = %1; closeDialog 0;", _forEachIndex]];
    } forEach _ans;
};
