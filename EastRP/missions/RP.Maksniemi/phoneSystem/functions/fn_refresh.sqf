/* Redessine la page courante. Si un paramètre (en secondes) est donné, attend avant de redessiner (utile après une requête au serveur). */
params [["_delay", 0]];
[_delay] spawn {
    params ["_delay"];
    if (_delay > 0) then { uiSleep _delay; };
    if (PHN_open && {PHN_curPage isNotEqualTo []} && {!isNull (uiNamespace getVariable ["PHN_display", displayNull])}) then { PHN_curPage call PHN_fnc_showPage; };
};
