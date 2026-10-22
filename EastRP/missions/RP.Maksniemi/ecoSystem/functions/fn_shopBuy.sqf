/* Achat d'un article. params: [identifiant de l'article] */
params ["_id"];
private _e = uiNamespace getVariable ["ECO_edit", controlNull];
private _q = ((floor (parseNumber (ctrlText _e))) max 1) min 20;
private _item = getText (missionConfigFile >> "ECO_Shops" >> ECO_type >> "Items" >> _id >> "item");
if (_item == "") exitWith {};
[format ["envoi au serveur : achat %1 x%2 (boutique %3, type %4)", _id, _q, ECO_obj, ECO_type]] call ECO_fnc_dbg;
[player, ECO_obj, _id, _q] remoteExec ["ECO_fnc_srvBuy", 2];
