/* Tant que l'inventaire est ouvert : branche le double-clic partout et renomme les objets */
disableSerialization;
private _cfg = missionConfigFile >> "DOC_Settings";
private _idCls  = getText (_cfg >> "itemIdCard");
private _licCls = getText (_cfg >> "itemLicense");

private _disp = findDisplay 602;
if (isNull _disp) exitWith {};
if (DOC_debug) then { systemChat "[DOC debug] inventaire détecté"; };

// (le double-clic est branché sur chaque liste ci-dessous ; "MouseButtonDblClick" n'existe pas comme évènement d'écran)

private _first = true;
while { !isNull _disp } do {
    private _lists = 0;
    {
        private _c = _x;
        private _type = ctrlType _c;
        if (_type == 102 || _type == 5) then {
            _lists = _lists + 1;
            // EH sur chaque liste (double-clic de liste + double-clic souris)
            if (isNil { _c getVariable "DOC_hooked" }) then {
                _c setVariable ["DOC_hooked", true];
                _c ctrlAddEventHandler ["LBDblClick", { params ["_ctl", "_i"]; [_ctl, _i] call DOC_fnc_invUse; }];
                _c ctrlAddEventHandler ["MouseButtonDblClick", { params ["_ctl", "_b"]; if (_b == 0) then { [_ctl, -1] call DOC_fnc_invUse; }; }];
                if (DOC_debug) then { diag_log format ["[DOC] liste inventaire branchée : idc=%1 type=%2", ctrlIDC _c, _type]; };
            };
            // Renommage
            private _n = if (_type == 102) then { (lnbSize _c) select 0 } else { lbSize _c };
            for "_i" from 0 to (_n - 1) do {
                private _cls = [_c, _i] call DOC_fnc_ctrlItemClass;
                private _name = "";
                if (_cls == _idCls)  then { _name = "Carte d'identité"; };
                if (_cls == _licCls) then { _name = "Permis de conduire"; };
                if (_name != "") then {
                    if (_type == 102) then { _c lnbSetText [[_i, 1], _name]; } else { _c lbSetText [_i, _name]; };
                };
            };
        };
    } forEach ([_disp] call DOC_fnc_deepControls);

    if (_first && DOC_debug) then { systemChat format ["[DOC debug] %1 liste(s) d'inventaire trouvée(s)", _lists]; _first = false; };
    uiSleep 0.4;
};
