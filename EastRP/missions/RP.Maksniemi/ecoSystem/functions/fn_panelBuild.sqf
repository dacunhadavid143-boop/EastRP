/* Construit l'interface (distributeur ou boutique), centrée. params: [display] */
disableSerialization;
params ["_d"];
private _sym = getText (missionConfigFile >> "CORE_Settings" >> "currencySymbol");
private _mk = {
    params ["_cls", "_px", "_py", "_pw", "_ph"];
    private _c = _d ctrlCreate [_cls, -1];
    _c ctrlSetPosition [_px, _py, _pw, _ph];
    _c ctrlCommit 0;
    _c
};
private _w = 0.56;
private _items = [];
private _h = 0.60;
if (ECO_mode == "shop") then {
    _items = "true" configClasses (missionConfigFile >> "ECO_Shops" >> ECO_type >> "Items");
    _h = 0.25 + ((count _items) min 8) * 0.072;
};
private _x0 = safeZoneX + safeZoneW / 2 - _w / 2;
private _y0 = safeZoneY + safeZoneH / 2 - _h / 2;

// Fond, filet doré, titre
private _bg = ["ECO_RscText", _x0, _y0, _w, _h] call _mk;
_bg ctrlSetBackgroundColor [0.05, 0.06, 0.08, 0.93];
private _ln = ["ECO_RscText", _x0, _y0, _w, 0.006] call _mk;
_ln ctrlSetBackgroundColor [0.90, 0.76, 0.30, 1];
private _title = ["ECO_RscText", _x0 + 0.02, _y0 + 0.018, _w - 0.04, 0.05] call _mk;
_title ctrlSetFont "PuristaBold";
_title ctrlSetFontHeight 0.05;
_title ctrlSetText (if (ECO_mode == "atm") then { "Distributeur" } else { getText (missionConfigFile >> "ECO_Shops" >> ECO_type >> "displayName") });

// Bouton Fermer
private _close = ["ECO_RscButton", _x0 + _w - 0.17, _y0 + _h - 0.07, 0.15, 0.05] call _mk;
_close ctrlSetText "Fermer";
_close ctrlAddEventHandler ["ButtonClick", { closeDialog 0; }];

if (ECO_mode == "atm") then {
    private _lb = ["ECO_RscText", _x0 + 0.02, _y0 + 0.09, _w - 0.04, 0.045] call _mk;
    private _lc = ["ECO_RscText", _x0 + 0.02, _y0 + 0.14, _w - 0.04, 0.045] call _mk;
    uiNamespace setVariable ["ECO_lblBank", _lb];
    uiNamespace setVariable ["ECO_lblCash", _lc];
    private _l1 = ["ECO_RscText", _x0 + 0.02, _y0 + 0.215, _w - 0.04, 0.035] call _mk;
    _l1 ctrlSetFontHeight 0.03; _l1 ctrlSetTextColor [1,1,1,0.6]; _l1 ctrlSetText "Montant";
    private _e = ["ECO_RscEdit", _x0 + 0.02, _y0 + 0.25, _w - 0.04, 0.055] call _mk;
    _e ctrlSetText "100";
    uiNamespace setVariable ["ECO_edit", _e];
    {
        private _b = ["ECO_RscButton", _x0 + 0.02 + _forEachIndex * 0.1, _y0 + 0.32, 0.092, 0.045] call _mk;
        _b ctrlSetText format ["%1", _x];
        _b setVariable ["ECO_v", _x];
        _b ctrlAddEventHandler ["ButtonClick", { params ["_c"]; [_c getVariable "ECO_v"] call ECO_fnc_atmQuick; }];
    } forEach [50, 100, 500, 1000, 5000];
    private _bd = ["ECO_RscButton", _x0 + 0.02, _y0 + 0.39, 0.245, 0.06] call _mk;
    _bd ctrlSetText "Déposer";
    _bd ctrlSetBackgroundColor [0.15, 0.55, 0.30, 1];
    _bd setVariable ["ECO_v", "deposit"];
    _bd ctrlAddEventHandler ["ButtonClick", { params ["_c"]; [_c getVariable "ECO_v"] call ECO_fnc_atmDo; }];
    private _br = ["ECO_RscButton", _x0 + 0.295, _y0 + 0.39, 0.245, 0.06] call _mk;
    _br ctrlSetText "Retirer";
    _br ctrlSetBackgroundColor [0.80, 0.45, 0.12, 1];
    _br setVariable ["ECO_v", "withdraw"];
    _br ctrlAddEventHandler ["ButtonClick", { params ["_c"]; [_c getVariable "ECO_v"] call ECO_fnc_atmDo; }];

    [_sym] spawn {
        disableSerialization;
        params ["_s"];
        while { !isNull findDisplay 74500 } do {
            private _lb = uiNamespace getVariable ["ECO_lblBank", controlNull];
            private _lc = uiNamespace getVariable ["ECO_lblCash", controlNull];
            if (!isNull _lb) then { _lb ctrlSetText format ["Compte bancaire : %1 %2", [player getVariable ["CORE_bank", 0]] call CORE_fnc_fmt, _s]; };
            if (!isNull _lc) then { _lc ctrlSetText format ["Espèces : %1 %2", [player getVariable ["CORE_cash", 0]] call CORE_fnc_fmt, _s]; };
            uiSleep 0.3;
        };
    };
} else {
    private _lc = ["ECO_RscText", _x0 + 0.02, _y0 + 0.08, _w - 0.04, 0.04] call _mk;
    uiNamespace setVariable ["ECO_lblCash", _lc];
    private _lq = ["ECO_RscText", _x0 + 0.02, _y0 + 0.125, 0.30, 0.04] call _mk;
    _lq ctrlSetFontHeight 0.03; _lq ctrlSetTextColor [1,1,1,0.6]; _lq ctrlSetText "Quantité";
    private _e = ["ECO_RscEdit", _x0 + 0.20, _y0 + 0.12, 0.10, 0.045] call _mk;
    _e ctrlSetText "1";
    uiNamespace setVariable ["ECO_edit", _e];
    {
        if (_forEachIndex < 8) then {
            private _yy = _y0 + 0.195 + _forEachIndex * 0.072;
            private _row = ["ECO_RscText", _x0 + 0.02, _yy, _w - 0.04, 0.062] call _mk;
            _row ctrlSetBackgroundColor [1, 1, 1, 0.07];
            private _n = ["ECO_RscText", _x0 + 0.035, _yy + 0.012, 0.28, 0.04] call _mk;
            _n ctrlSetText getText (_x >> "displayName");
            private _p = ["ECO_RscTextR", _x0 + 0.30, _yy + 0.012, 0.12, 0.04] call _mk;
            _p ctrlSetTextColor [0.90, 0.76, 0.30, 1];
            _p ctrlSetText format ["%1 %2", getNumber (_x >> "price"), _sym];
            private _b = ["ECO_RscButton", _x0 + _w - 0.145, _yy + 0.006, 0.12, 0.05] call _mk;
            _b ctrlSetText "Acheter";
            _b setVariable ["ECO_v", configName _x];
            _b ctrlAddEventHandler ["ButtonClick", { params ["_c"]; [_c getVariable "ECO_v"] call ECO_fnc_shopBuy; }];
        };
    } forEach _items;

    [_sym] spawn {
        disableSerialization;
        params ["_s"];
        while { !isNull findDisplay 74500 } do {
            private _lc = uiNamespace getVariable ["ECO_lblCash", controlNull];
            if (!isNull _lc) then { _lc ctrlSetText format ["Espèces : %1 %2", [player getVariable ["CORE_cash", 0]] call CORE_fnc_fmt, _s]; };
            uiSleep 0.3;
        };
    };
};
[format ["panneau construit : mode=%1 type=%2 articles=%3", ECO_mode, ECO_type, count _items]] call ECO_fnc_dbg;
