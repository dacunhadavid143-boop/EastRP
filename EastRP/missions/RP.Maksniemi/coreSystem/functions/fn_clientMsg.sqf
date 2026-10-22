/* CLIENT : affiche un message venant du serveur. params: [texte] */
params [["_m", ""]];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
systemChat _m;
