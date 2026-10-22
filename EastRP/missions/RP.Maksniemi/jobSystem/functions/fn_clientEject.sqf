/* CLIENT : fait descendre le joueur d'un véhicule (véhicule de service qui ne lui appartient pas, ou rangé). Envoyé par le serveur. params: [véhicule] */
params ["_v"];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
if (!isNull _v && {vehicle player == _v}) then { moveOut player; };
