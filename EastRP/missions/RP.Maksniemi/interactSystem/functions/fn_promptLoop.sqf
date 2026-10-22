/* CLIENT : affiche "[TAB] Interagir - cible" en bas de l'écran quand une interaction est possible. */
disableSerialization;
private _cfg = missionConfigFile >> "INT_Settings";
private _c = controlNull;
while { true } do {
    uiSleep ((getNumber (_cfg >> "scanSeconds")) max 0.1);
    private _d = findDisplay 46;
    private _show = (getNumber (_cfg >> "showPrompt") == 1) && {!isNull _d} && {alive player} && {!dialog} && {!isNil { player getVariable "CORE_cash" }};
    private _items = if (_show) then { call INT_fnc_scan } else { [] };
    if (_items isEqualTo []) then {
        if (!isNull _c) then { ctrlDelete _c; _c = controlNull; };
    } else {
        if (isNull _c) then {
            _c = _d ctrlCreate ["INT_RscStruct", -1];
            _c ctrlSetPosition [safeZoneX + safeZoneW / 2 - 0.20, safeZoneY + safeZoneH - 0.20, 0.40, 0.050];
            _c ctrlCommit 0;
        };
        private _key = toString ((toArray (keyName INT_key)) select { _x != 34 });
        _c ctrlSetStructuredText parseText format [
            "<t size='0.85'>[<t color='#e6c14d'>%1</t>] Interagir - %2%3</t>",
            _key, (_items select 0) select 4, if (count _items > 1) then { format [" (%1)", count _items] } else { "" }
        ];
    };
};
