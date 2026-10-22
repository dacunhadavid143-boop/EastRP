/* Dépôt ou retrait. params: ["deposit"|"withdraw"] */
params ["_op"];
private _e = uiNamespace getVariable ["ECO_edit", controlNull];
private _a = floor (parseNumber (ctrlText _e));
if (_a <= 0) exitWith { systemChat "[Distributeur] Saisissez un montant."; };
[format ["envoi au serveur : %1 %2 (distributeur %3)", _op, _a, ECO_obj]] call ECO_fnc_dbg;
[player, ECO_obj, _op, _a] remoteExec ["ECO_fnc_srvAtm", 2];
