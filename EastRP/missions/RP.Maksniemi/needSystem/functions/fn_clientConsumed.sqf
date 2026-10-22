/* CLIENT : le serveur a validé la consommation : on retire l'objet de l'inventaire. params: [classe, nom] */
params ["_cls", "_name"];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
if ((magazines player) findIf { (toLower _x) == (toLower _cls) } != -1) then { player removeMagazine _cls; } else { player removeItem _cls; };
systemChat format ["Vous utilisez : %1", _name];
