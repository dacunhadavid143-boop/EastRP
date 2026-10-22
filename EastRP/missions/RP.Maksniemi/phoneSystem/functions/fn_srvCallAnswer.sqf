/* SERVEUR : l'appelé répond ou refuse. params: [unit, accepter(bool)] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_accept", false, [false]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
private _id = _unit getVariable ["PHN_callId", -1];
if (_id < 0) exitWith {};
private _rec = PHN_calls getOrDefault [format ["c%1", _id], []];
if (_rec isEqualTo [] || {(_rec select 2) != "ringing"} || {(_rec select 1) != _unit}) exitWith {};

if (!_accept) exitWith { [_id, "Appel refusé."] call PHN_fnc_srvEndCall; };

private _i = PHN_pool findIf { !(_x select 1) };
if (_i < 0) exitWith { [_id, "Aucune ligne disponible."] call PHN_fnc_srvEndCall; };
private _ch = (PHN_pool select _i) select 0;
(PHN_pool select _i) set [1, true];
_rec params ["_a", "_b"];
_ch radioChannelAdd [_a, _b];
_rec set [2, "active"];
_rec set [3, _ch];
["active", [[_b, "phone", ""] call CORE_fnc_getValue, _ch]] remoteExec ["PHN_fnc_clientCall", _a];
["active", [[_a, "phone", ""] call CORE_fnc_getValue, _ch]] remoteExec ["PHN_fnc_clientCall", _b];
