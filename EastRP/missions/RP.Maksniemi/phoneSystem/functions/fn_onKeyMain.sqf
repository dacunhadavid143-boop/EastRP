/* Touche pressée dans le jeu (aucune fenêtre ouverte). params: [display, touche, shift, ctrl, alt] */
params ["_d", "_key", "_shift", "_ctrl", "_alt"];
if (_key != PHN_key || _shift || _ctrl || _alt) exitWith { false };
if (dialog || !alive player || {isNil { player getVariable "CORE_cash" }}) exitWith { false };
[] call PHN_fnc_open;
true
