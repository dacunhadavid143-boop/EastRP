/* CLIENT : enregistre un objet physique utilisable par double-clic dans l'inventaire.
   params: [classe, code, nom affiché (optionnel)]. Le code reçoit [classe]. (clé en minuscules) */
params ["_cls", "_code", ["_name", ""]];
if (isNil "CORE_itemUse") then { CORE_itemUse = createHashMap; };
CORE_itemUse set [toLower _cls, [_code, _name]];
