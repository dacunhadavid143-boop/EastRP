/* SERVEUR : le client signale qu'il a spawn : on s'assure que faim/soif existent (double sécurité). params: [unit] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
private _uid = getPlayerUID _unit;
private _t = diag_tickTime + 15;
waitUntil { (count (CORE_sessions getOrDefault [_uid, createHashMap])) > 0 || diag_tickTime > _t };
if ((count (CORE_sessions getOrDefault [_uid, createHashMap])) == 0) exitWith { diag_log "[NEED] srvHello : session CORE introuvable (le noyau n'a pas chargé le joueur)"; };
[_unit] call NEED_fnc_loadDefaults;
