/* SERVEUR : le client demande son état d'emploi à jour (ex : à l'ouverture du Pôle Emploi). params: [unit] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
[_unit] call JOB_fnc_srvSync;
