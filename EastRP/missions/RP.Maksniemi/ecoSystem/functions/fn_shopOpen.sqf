/* Ouvre l'interface de la boutique. params: [objet] */
params ["_o"];
ECO_obj = _o;
ECO_mode = "shop";
ECO_type = [_o] call ECO_fnc_shopType;
[format ["ouverture de la boutique : objet=%1 classe=%2 type=%3", _o, typeOf _o, ECO_type]] call ECO_fnc_dbg;
createDialog "ECO_Panel";
