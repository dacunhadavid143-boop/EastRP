/* SERVEUR : renvoie l'identité stockée (ou []). params: [unit] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
private _data = profileNamespace getVariable [format ["DOC_id_%1", getPlayerUID _unit], []];
// Mode test : on fait comme si aucune identité n'existait
if (getNumber (missionConfigFile >> "DOC_Settings" >> "testMode") == 1) then { _data = []; };
[_data, ""] remoteExec ["DOC_fnc_clientReceive", _unit];
