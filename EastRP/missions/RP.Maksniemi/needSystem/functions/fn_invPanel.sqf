/* CLIENT : affiche santé / faim / soif dans un coin de l'écran d'inventaire (display 602). */
disableSerialization;
private _cfg = missionConfigFile >> "NEED_Settings";
private _corner = getText (_cfg >> "invCorner");
if (_corner == "") then { _corner = "bottomleft"; };
private _rows = [["SANTE", [0.85, 0.2, 0.2, 1]], ["FAIM", [0.95, 0.6, 0.15, 1]], ["SOIF", [0.25, 0.6, 0.95, 1]]];

while { true } do {
    waitUntil { uiSleep 0.2; !isNull findDisplay 602 };
    private _d = findDisplay 602;
    if (getNumber (_cfg >> "showInInventory") == 1 && {!isNil { player getVariable "NEED_hunger" }}) then {
        private _p = [_corner, 0.32, 0.18] call CORE_fnc_cornerPos;
        _p params ["_x0", "_y0", "_w", "_h"];
        private _bg = _d ctrlCreate ["NEED_RscText", 75310];
        _bg ctrlSetPosition [_x0, _y0, _w, _h];
        _bg ctrlSetBackgroundColor [0, 0, 0, 0.55];
        _bg ctrlCommit 0;

        private _labels = [];
        private _fills = [];
        {
            _x params ["_name", "_col"];
            private _yy = _y0 + 0.012 + _forEachIndex * 0.055;
            private _l = _d ctrlCreate ["NEED_RscText", 75311 + _forEachIndex * 3];
            _l ctrlSetPosition [_x0 + 0.012, _yy, _w - 0.024, 0.03];
            _l ctrlCommit 0;
            private _b = _d ctrlCreate ["NEED_RscText", 75312 + _forEachIndex * 3];
            _b ctrlSetPosition [_x0 + 0.012, _yy + 0.032, _w - 0.024, 0.012];
            _b ctrlSetBackgroundColor [1, 1, 1, 0.15];
            _b ctrlCommit 0;
            private _f = _d ctrlCreate ["NEED_RscText", 75313 + _forEachIndex * 3];
            _f ctrlSetPosition [_x0 + 0.012, _yy + 0.032, _w - 0.024, 0.012];
            _f ctrlSetBackgroundColor _col;
            _f ctrlCommit 0;
            _labels pushBack _l;
            _fills pushBack _f;
        } forEach _rows;

        while { !isNull _d } do {
            private _vals = [
                round ((1 - (damage player)) * 100),
                round (player getVariable ["NEED_hunger", 0]),
                round (player getVariable ["NEED_thirst", 0])
            ];
            {
                private _v = _x;
                (_labels select _forEachIndex) ctrlSetText format ["%1  %2 %%", (_rows select _forEachIndex) select 0, _v];
                private _f = _fills select _forEachIndex;
                _f ctrlSetPosition [_x0 + 0.012, (ctrlPosition _f) select 1, (_w - 0.024) * ((_v / 100) max 0.003 min 1), 0.012];
                _f ctrlCommit 0;
            } forEach _vals;
            uiSleep 0.3;
        };
    } else {
        waitUntil { uiSleep 0.3; isNull findDisplay 602 };
    };
};
