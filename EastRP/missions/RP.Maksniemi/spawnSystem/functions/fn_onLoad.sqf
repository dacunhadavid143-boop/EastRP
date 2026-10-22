/* SPN_fnc_onLoad : remplit l'écran et lance l'animation d'apparition. params: [display] */
params ["_display"];
private _p = SPN_points select 0;
private _cfg = missionConfigFile >> "SPN_Settings";

(_display displayCtrl 74101) ctrlSetText getText (_cfg >> "serverName");
(_display displayCtrl 74102) ctrlSetText (_p select 1);
(_display displayCtrl 74103) ctrlSetStructuredText parseText (_p select 2);
(_display displayCtrl 74104) ctrlSetStructuredText parseText format ["Bienvenue, <t color='#e6c14d'>%1</t>", profileName];
(_display displayCtrl 74105) ctrlEnable ([_p] call SPN_fnc_canSpawn);

// Apparition progressive, élément par élément
private _sequence = [
    [74108, 0.0], [74109, 0.0], [74101, 0.5],
    [74106, 0.8], [74102, 1.2], [74107, 0.6],
    [74103, 0.8], [74104, 0.6], [74105, 0.8]
];
{ private _c = _display displayCtrl (_x select 0); _c ctrlSetFade 1; _c ctrlCommit 0; } forEach _sequence;

[_display, _sequence] spawn {
    params ["_display", "_sequence"];
    {
        if (isNull _display) exitWith {};
        private _c = _display displayCtrl (_x select 0);
        _c ctrlSetFade 0;
        _c ctrlCommit 1.2;
        uiSleep (_x select 1);
    } forEach _sequence;
};
