/* SERVEUR : un participant raccroche. params: [unit] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
private _id = _unit getVariable ["PHN_callId", -1];
if (_id >= 0) then { [_id, "Appel terminé."] call PHN_fnc_srvEndCall; };
