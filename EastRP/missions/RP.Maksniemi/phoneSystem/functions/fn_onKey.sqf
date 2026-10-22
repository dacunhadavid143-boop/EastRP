/* Touche pressée pendant que le téléphone est ouvert. params: [display, touche, ...] */
params ["_d", "_key"];
if (PHN_capture) exitWith {
    if (_key in [1, 28, 156]) exitWith { PHN_capture = false; true };      // Échap / Entrée : annule
    PHN_key = _key;
    profileNamespace setVariable ["PHN_key", _key];
    saveProfileNamespace;
    PHN_capture = false;
    [] call PHN_fnc_refresh;
    true
};
if (_key == PHN_key) then {
    private _f = focusedCtrl _d;
    if (isNull _f || {ctrlType _f != 2}) exitWith { closeDialog 0; true };   // pas de fermeture quand on tape dans un champ de texte
    false
} else { false }
