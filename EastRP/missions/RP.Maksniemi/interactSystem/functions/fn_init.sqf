/* INT_fnc_init (postInit) : client */
if (!hasInterface) exitWith {};
if (isNil "INT_actions") then { INT_actions = []; };       // [id, libellé, type de cible, condition, action, ordre]
if (isNil "INT_points")  then { INT_points = createHashMap; };   // type -> [libellé, préfixe de marqueur, rayon]
INT_markers = createHashMap;
INT_nextRefresh = 0;
INT_menuItems = [];
INT_dbg = "";
INT_key = profileNamespace getVariable ["INT_key", getNumber (missionConfigFile >> "INT_Settings" >> "defaultKey")];

// Touche d'interaction : écoute sur l'écran principal du jeu
[] spawn {
    waitUntil { !isNull findDisplay 46 };
    (findDisplay 46) displayAddEventHandler ["KeyDown", { _this call INT_fnc_onKeyMain }];
};

// Indication à l'écran
[] spawn INT_fnc_promptLoop;

// Exemples de test (devMode)
call INT_fnc_demo;
