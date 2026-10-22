/* Remplit le formulaire. params: [display] */
params ["_d"];
private _cfg = missionConfigFile >> "DOC_Settings";
private _n = [profileName] call DOC_fnc_parseName;
DOC_formResult = "";

(_d displayCtrl 74226) ctrlSetText getText (_cfg >> "country");
private _t = systemTime;
(_d displayCtrl 74225) ctrlSetText format ["Le %1", [[_t select 2, _t select 1, _t select 0]] call DOC_fnc_fmtDate];

private _fill = {
    params ["_ctrl", "_items"];
    lbClear _ctrl;
    { _ctrl lbAdd _x; } forEach _items;
    _ctrl lbSetCurSel 0;
};

[_d displayCtrl 74213, ["Masculin / М", "Féminin / Ж"]] call _fill;

private _days = []; for "_i" from 1 to 31 do { _days pushBack format ["%1", _i]; };
[_d displayCtrl 74214, _days] call _fill;

[_d displayCtrl 74215, ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"]] call _fill;

private _years = []; for "_i" from 18 to 80 do { _years pushBack format ["%1", (_t select 0) - _i]; };
[_d displayCtrl 74216, _years] call _fill;
(_d displayCtrl 74216) lbSetCurSel 12;

[_d displayCtrl 74217, getArray (_cfg >> "birthPlaces")] call _fill;

private _heights = []; for "_i" from 150 to 205 do { _heights pushBack format ["%1", _i]; };
[_d displayCtrl 74218, _heights] call _fill;
(_d displayCtrl 74218) lbSetCurSel 28;

[_d displayCtrl 74219, getArray (_cfg >> "eyes")] call _fill;
[_d displayCtrl 74220, getArray (_cfg >> "licenceCats")] call _fill;

if (_n isEqualTo []) then {
    (_d displayCtrl 74211) ctrlSetText "—";
    (_d displayCtrl 74212) ctrlSetText "—";
    (_d displayCtrl 74222) ctrlSetText "Nom de profil invalide : il doit être au format « Prénom Nom ».";
    (_d displayCtrl 74223) ctrlEnable false;
} else {
    (_d displayCtrl 74211) ctrlSetText (_n select 1);
    (_d displayCtrl 74212) ctrlSetText (_n select 0);
};
