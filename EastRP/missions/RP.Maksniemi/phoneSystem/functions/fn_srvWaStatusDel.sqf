/* SERVEUR : supprime le statut du joueur. params: [unit] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
private _my = [_unit, "phone", ""] call CORE_fnc_getValue;
PHN_statuses = PHN_statuses select { (_x select 0) != _my };
call PHN_fnc_srvWaSave;
call PHN_fnc_srvWaPush;
