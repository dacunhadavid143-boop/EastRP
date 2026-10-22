/* true si l'objet est un distributeur (classe de l'addon, variable eastrp_role, ou classe listée dans ECO_Settings). params: [objet] */
params ["_o"];
if (isNull _o) exitWith { false };
private _t = typeOf _o;
if ((_o getVariable ["eastrp_role", ""]) == "atm") exitWith { true };
if (getText (configFile >> "CfgVehicles" >> _t >> "eastrp_role") == "atm") exitWith { true };
(toLower _t) in ((getArray (missionConfigFile >> "ECO_Settings" >> "atmClasses")) apply { toLower _x })
