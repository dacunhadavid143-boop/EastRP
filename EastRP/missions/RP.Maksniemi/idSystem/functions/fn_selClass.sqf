/* Objet actuellement sélectionné dans l'inventaire. params: [display] -> [control, ligne, classe] */
params ["_disp"];
private _c = focusedCtrl _disp;
if (isNull _c) exitWith { [controlNull, -1, ""] };
private _row = switch (ctrlType _c) do {
    case 102: { lnbCurSelRow _c };
    case 5:   { lbCurSel _c };
    default   { -1 };
};
[_c, _row, [_c, _row] call DOC_fnc_ctrlItemClass]
