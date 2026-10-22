/* Ouvre l'interface du distributeur. params: [objet] */
params ["_o"];
ECO_obj = _o;
ECO_mode = "atm";
[format ["ouverture du distributeur : objet=%1 classe=%2", _o, typeOf _o]] call ECO_fnc_dbg;
createDialog "ECO_Panel";
