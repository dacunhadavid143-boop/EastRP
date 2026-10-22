/* Met à jour l'heure (heure du jeu) et le chronomètre d'appel tant que le téléphone est ouvert */
disableSerialization;
private _p = { params ["_n"]; if (_n < 10) then { format ["0%1", _n] } else { format ["%1", _n] } };
while { PHN_open && {!isNull (uiNamespace getVariable ["PHN_display", displayNull])} } do {
    private _t = daytime;
    private _h = floor _t;
    private _m = floor ((_t - _h) * 60);
    if (!isNull (uiNamespace getVariable ["PHN_clock", controlNull])) then { (uiNamespace getVariable "PHN_clock") ctrlSetText format ["%1:%2", [_h] call _p, [_m] call _p]; };
    if ((PHN_call select 0) == "active") then {
        private _tc = PHN_refs getOrDefault ["callTimer", controlNull];
        if (!isNull _tc) then {
            private _s = floor (time - (PHN_call select 2));
            _tc ctrlSetText format ["%1:%2", [floor (_s / 60)] call _p, [_s mod 60] call _p];
        };
    };
    uiSleep 1;
};
