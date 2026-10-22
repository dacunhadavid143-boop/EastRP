/* Bouton de montant rapide. params: [montant] */
params ["_v"];
private _e = uiNamespace getVariable ["ECO_edit", controlNull];
if (!isNull _e) then { _e ctrlSetText format ["%1", _v]; };
