/* CLIENT : barres santé / faim / soif visibles EN PERMANENCE (coin configurable), dessinées sur l'écran principal du jeu. Lecture seule. */
disableSerialization;
private _cfg = missionConfigFile >> "NEED_Settings";
private _rows = [["SANTE", [0.85, 0.2, 0.2, 1]], ["FAIM", [0.95, 0.6, 0.15, 1]], ["SOIF", [0.25, 0.6, 0.95, 1]]];
private _all = [];
private _labels = [];
private _fills = [];
private _x0 = 0;
private _w = 0;

while { true } do {
    uiSleep 0.5;
    private _d = findDisplay 46;
    private _show = (getNumber (_cfg >> "showOnScreen") == 1) && {!isNull _d} && {!isNull player} && {alive player} && {!isNil { player getVariable "NEED_hunger" }};

    if (_show) then {
        if (_all isEqualTo [] || {isNull (_all select 0)}) then {
            private _corner = getText (_cfg >> "hudCorner");
            if (_corner == "") then { _corner = "bottomleft"; };
            private _p = [_corner, 0.30, 0.17] call CORE_fnc_cornerPos;
            _p params ["_px", "_py", "_pw", "_ph"];
            _x0 = _px; _w = _pw;
            _all = []; _labels = []; _fills = [];
            private _bg = _d ctrlCreate ["NEED_RscText", -1];
            _bg ctrlSetPosition [_px, _py, _pw, _ph];
            _bg ctrlSetBackgroundColor [0, 0, 0, 0.45];
            _bg ctrlCommit 0;
            _all pushBack _bg;
            {
                _x params ["_name", "_col"];
                private _yy = _py + 0.010 + _forEachIndex * 0.052;
                private _l = _d ctrlCreate ["NEED_RscText", -1];
                _l ctrlSetPosition [_px + 0.012, _yy, _pw - 0.024, 0.028];
                _l ctrlCommit 0;
                private _b = _d ctrlCreate ["NEED_RscText", -1];
                _b ctrlSetPosition [_px + 0.012, _yy + 0.030, _pw - 0.024, 0.011];
                _b ctrlSetBackgroundColor [1, 1, 1, 0.15];
                _b ctrlCommit 0;
                private _f = _d ctrlCreate ["NEED_RscText", -1];
                _f ctrlSetPosition [_px + 0.012, _yy + 0.030, _pw - 0.024, 0.011];
                _f ctrlSetBackgroundColor _col;
                _f ctrlCommit 0;
                _all append [_l, _b, _f];
                _labels pushBack _l;
                _fills pushBack _f;
            } forEach _rows;
        };
        private _vals = [
            round ((1 - (damage player)) * 100),
            round (player getVariable ["NEED_hunger", 0]),
            round (player getVariable ["NEED_thirst", 0])
        ];
        {
            private _v = _x;
            (_labels select _forEachIndex) ctrlSetText format ["%1  %2 %%", (_rows select _forEachIndex) select 0, _v];
            private _f = _fills select _forEachIndex;
            _f ctrlSetPosition [_x0 + 0.012, (ctrlPosition _f) select 1, (_w - 0.024) * ((_v / 100) max 0.003 min 1), 0.011];
            _f ctrlCommit 0;
        } forEach _vals;
    } else {
        if (_all isNotEqualTo []) then {
            { if (!isNull _x) then { ctrlDelete _x; }; } forEach _all;
            _all = []; _labels = []; _fills = [];
        };
    };
};
