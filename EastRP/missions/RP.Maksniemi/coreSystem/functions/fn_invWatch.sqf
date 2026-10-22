/* CLIENT : tant que l'inventaire est ouvert, branche le double-clic et renomme les objets enregistrés. */
disableSerialization;
while { true } do {
    waitUntil { uiSleep 0.2; !isNull findDisplay 602 };
    private _disp = findDisplay 602;
    if (getNumber (missionConfigFile >> "CORE_Settings" >> "debug") == 1) then { systemChat format ["[CORE debug] inventaire détecté, %1 objet(s) utilisable(s) enregistré(s)", count CORE_itemUse]; };

    // (le double-clic est branché sur les contrôles de la liste ci-dessous ; "MouseButtonDblClick" n'existe pas comme évènement d'écran)

    while { !isNull _disp } do {
        {
            private _c = _x;
            private _type = ctrlType _c;
            if (_type == 102 || _type == 5) then {
                if (isNil { _c getVariable "CORE_hooked" }) then {
                    _c setVariable ["CORE_hooked", true];
                    _c ctrlAddEventHandler ["LBDblClick", { params ["_ctl", "_i"]; [_ctl, _i] call CORE_fnc_invUse; }];
                    _c ctrlAddEventHandler ["MouseButtonDblClick", { params ["_ctl", "_b"]; if (_b == 0) then { [_ctl, -1] call CORE_fnc_invUse; }; }];
                };
                private _n = if (_type == 102) then { (lnbSize _c) select 0 } else { lbSize _c };
                for "_i" from 0 to (_n - 1) do {
                    private _def = CORE_itemUse getOrDefault [toLower ([_c, _i] call CORE_fnc_ctrlItemClass), []];
                    if (_def isNotEqualTo [] && {(_def select 1) != ""}) then {
                        if (_type == 102) then { _c lnbSetText [[_i, 1], _def select 1]; } else { _c lbSetText [_i, _def select 1]; };
                    };
                };
            };
        } forEach ([_disp] call CORE_fnc_deepControls);
        uiSleep 0.4;
    };
};
