/* En-tête standard d'une application : titre centré + bouton retour. params: [titre, retour(true/false)] */
params ["_title", ["_back", true]];
[0, 0.012, 1, 0.05, _title, 0.034, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
if (_back) then {
    [0.02, 0.012, 0.28, 0.05, "< Retour", [0,0,0,0], [0.35,0.65,1,1], { [PHN_fnc_homePage, []] call PHN_fnc_showPage; }, [], 0, 0.028] call PHN_fnc_uiButton;
};
