/* Touches dans le menu : la touche d'interaction ferme le menu (Échap aussi). Les choix se font à la souris. params: [display, touche, ...] */
params ["_d", "_key"];
if (_key == INT_key) exitWith { closeDialog 0; true };
false
