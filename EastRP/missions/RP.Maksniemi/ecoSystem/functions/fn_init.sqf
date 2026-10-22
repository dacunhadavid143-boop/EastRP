/* ECO_fnc_init (postInit) : enregistre les interactions (module INT) */
if (!hasInterface) exitWith {};
ECO_obj  = objNull;
ECO_mode = "";
ECO_type = "";
[format ["initialisé : %1 interaction(s) enregistrée(s) au total", count INT_actions]] call ECO_fnc_dbg;

["eco_atm", "Distributeur", "object",
    { params ["_o"]; [_o] call ECO_fnc_isAtm },
    { params ["_o"]; [_o] call ECO_fnc_atmOpen; }, 10] call INT_fnc_registerAction;

["eco_shop", { params ["_o"]; getText (missionConfigFile >> "ECO_Shops" >> ([_o] call ECO_fnc_shopType) >> "displayName") }, "object",
    { params ["_o"]; ([_o] call ECO_fnc_shopType) != "" },
    { params ["_o"]; [_o] call ECO_fnc_shopOpen; }, 10] call INT_fnc_registerAction;
