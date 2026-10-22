/* Double-clic dans l'inventaire. params: [control, ligne (-1 = sélection courante)]. true si l'objet est géré par un module. */
params ["_c", "_row"];
if (isNull _c || {isNil "CORE_itemUse"}) exitWith { false };
if (_row < 0) then {
    _row = switch (ctrlType _c) do {
        case 102: { lnbCurSelRow _c };
        case 5:   { lbCurSel _c };
        default   { -1 };
    };
};
private _cls = [_c, _row] call CORE_fnc_ctrlItemClass;
if (getNumber (missionConfigFile >> "CORE_Settings" >> "debug") == 1) then {
    systemChat format ["[CORE debug] double-clic : idc=%1 type=%2 ligne=%3 classe='%4'", ctrlIDC _c, ctrlType _c, _row, _cls];
};
if (_cls == "") exitWith { false };
private _def = CORE_itemUse getOrDefault [toLower _cls, []];
if (_def isEqualTo []) exitWith { false };
if (diag_tickTime < CORE_dblLock) exitWith { true };     // anti double déclenchement
CORE_dblLock = diag_tickTime + 0.6;
[_cls] call (_def select 0);
true
