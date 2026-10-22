/* Utilise l'objet sélectionné dans une liste d'inventaire. params: [control, ligne(-1 = sélection courante)]. Renvoie true si c'est un document. */
params ["_c", "_row"];
if (isNull _c) exitWith { false };

if (_row < 0) then {
    _row = switch (ctrlType _c) do {
        case 102: { lnbCurSelRow _c };
        case 5:   { lbCurSel _c };
        default   { -1 };
    };
};
private _cls = [_c, _row] call DOC_fnc_ctrlItemClass;

if (DOC_debug) then {
    systemChat format ["[DOC debug] double-clic : idc=%1 type=%2 ligne=%3 classe='%4'", ctrlIDC _c, ctrlType _c, _row, _cls];
};

private _cfg = missionConfigFile >> "DOC_Settings";
private _type = "";
if (_cls == getText (_cfg >> "itemIdCard"))  then { _type = "id"; };
if (_cls == getText (_cfg >> "itemLicense")) then { _type = "licence"; };
if (_type == "") exitWith { false };

// anti double déclenchement (plusieurs EH sur le même clic)
if (diag_tickTime < DOC_dblLock) exitWith { true };
DOC_dblLock = diag_tickTime + 0.6;

(ctrlParent _c) closeDisplay 2;
[_type] spawn DOC_fnc_showCard;
true
