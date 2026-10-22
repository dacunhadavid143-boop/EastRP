/* Construit le menu d'interaction (centré). params: [display] */
disableSerialization;
params ["_d"];
private _items = INT_menuItems;
private _n = (count _items) min 10;
private _w = 0.46;
private _bh = 0.058;
private _gap = 0.008;
private _hh = 0.085;
private _h = _hh + _n * (_bh + _gap) + 0.02;
private _ox = safeZoneX + safeZoneW / 2 - _w / 2;
private _oy = safeZoneY + safeZoneH / 2 - _h / 2;

private _bg = _d ctrlCreate ["INT_RscText", -1];
_bg ctrlSetPosition [_ox, _oy, _w, _h];
_bg ctrlSetBackgroundColor [0, 0, 0, 0.82];
_bg ctrlCommit 0;
private _line = _d ctrlCreate ["INT_RscText", -1];
_line ctrlSetPosition [_ox, _oy, _w, 0.005];
_line ctrlSetBackgroundColor [0.90, 0.76, 0.30, 1];
_line ctrlCommit 0;
private _t = _d ctrlCreate ["INT_RscText", -1];
_t ctrlSetPosition [_ox + 0.015, _oy + 0.012, _w - 0.03, 0.04];
_t ctrlSetFont "PuristaBold";
_t ctrlSetFontHeight 0.04;
_t ctrlSetText ((_items select 0) select 4);
_t ctrlCommit 0;
private _s = _d ctrlCreate ["INT_RscText", -1];
_s ctrlSetPosition [_ox + 0.015, _oy + 0.050, _w - 0.03, 0.03];
_s ctrlSetFontHeight 0.026;
_s ctrlSetTextColor [1, 1, 1, 0.55];
_s ctrlSetText "Cliquez sur une option";
_s ctrlCommit 0;

{
    if (_forEachIndex < 10) then {
        private _b = _d ctrlCreate ["INT_RscButton", -1];
        _b ctrlSetPosition [_ox + 0.015, _oy + _hh + _forEachIndex * (_bh + _gap), _w - 0.03, _bh];
        _b ctrlSetText (_x select 1);
        _b setVariable ["INT_i", _forEachIndex];
        _b ctrlAddEventHandler ["ButtonClick", { params ["_c"]; [_c getVariable "INT_i"] call INT_fnc_menuUse; }];
        _b ctrlCommit 0;
    };
} forEach _items;
