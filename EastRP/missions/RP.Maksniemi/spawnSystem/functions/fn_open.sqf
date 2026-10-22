/* SPN_fnc_open : ouvre l'écran de spawn. À appeler avec spawn. params: [premierSpawn(bool)] */
params [["_first", false]];
if (SPN_isOpen) exitWith {};

SPN_points = call SPN_fnc_getPoints;
if (SPN_points isEqualTo []) exitWith { systemChat "[SPN] Aucun point de spawn configuré."; };

SPN_isOpen = true;
SPN_busy   = false;
SPN_selected = 0;
waitUntil { alive player };
player allowDamage false;

[SPN_points select 0] call SPN_fnc_camFocus;
call SPN_fnc_camStart;
cutText ["", "BLACK IN", 1.5];
createDialog "SPN_Dialog";
[missionNamespace, "SPN_menuOpened", [player, _first]] call BIS_fnc_callScriptedEventHandler;
