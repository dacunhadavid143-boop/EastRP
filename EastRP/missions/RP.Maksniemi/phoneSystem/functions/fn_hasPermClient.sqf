/* Affichage uniquement (le serveur re-vérifie TOUT). params: [permission] : "" = tout le monde, "admin" = tout rôle, sinon permission précise */
params [["_perm", ""]];
if (_perm == "") exitWith { true };
private _p = player getVariable ["PHN_perms", []];
if (_perm == "admin") exitWith { count _p > 0 };
_perm in _p
