/* Touche pressée dans le jeu. params: [display, touche, shift, ctrl, alt]. Ne bloque la touche que s'il y a quelque chose à faire. */
params ["_d", "_key", "_shift", "_ctrl", "_alt"];
if (_key != INT_key || _shift || _ctrl || _alt) exitWith { false };
private _dbg = getNumber (missionConfigFile >> "INT_Settings" >> "debug") == 1;
if (_dbg) then { systemChat format ["[INT debug] touche reçue (%1 action(s) enregistrée(s))", count INT_actions]; };
if (dialog) exitWith { if (_dbg) then { systemChat "[INT debug] ignoré : une fenêtre est déjà ouverte"; }; false };
if (!alive player) exitWith { if (_dbg) then { systemChat "[INT debug] ignoré : joueur mort"; }; false };
if (isNil { player getVariable "CORE_cash" }) exitWith { if (_dbg) then { systemChat "[INT debug] ignoré : données du joueur pas encore chargées (CORE_cash)"; }; false };
private _items = call INT_fnc_scan;
if (_items isEqualTo []) exitWith {
    if (_dbg) then { systemChat format ["[INT debug] rien à faire ici - %1", INT_dbg]; };
    false
};
INT_menuItems = _items;
createDialog "INT_Menu";
true
