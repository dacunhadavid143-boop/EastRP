/* SERVEUR : lance un appel. params: [unit, numéro] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_num", "", [""]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
private _msg = { params ["_m"]; [_m] remoteExec ["CORE_fnc_clientMsg", _unit]; };

if ((_unit getVariable ["PHN_callId", -1]) >= 0) exitWith { ["[Téléphone] Vous êtes déjà en communication."] call _msg; };
if (count _num != 7 || {((toArray _num) findIf { _x < 48 || _x > 57 }) != -1}) exitWith { ["[Téléphone] Numéro invalide (7 chiffres)."] call _msg; };
private _my = [_unit, "phone", ""] call CORE_fnc_getValue;
if (_num == _my) exitWith { ["[Téléphone] Vous ne pouvez pas vous appeler."] call _msg; };
private _callee = [_num] call PHN_fnc_findByNumber;
if (isNull _callee) exitWith { ["[Téléphone] Numéro injoignable."] call _msg; };
if ((_callee getVariable ["PHN_callId", -1]) >= 0) exitWith { ["[Téléphone] Ligne occupée."] call _msg; };

PHN_callSeq = PHN_callSeq + 1;
private _id = PHN_callSeq;
PHN_calls set [format ["c%1", _id], [_unit, _callee, "ringing", -1]];
_unit setVariable ["PHN_callId", _id];
_callee setVariable ["PHN_callId", _id];
["ringing", [_num]] remoteExec ["PHN_fnc_clientCall", _unit];
["incoming", [_my]] remoteExec ["PHN_fnc_clientCall", _callee];

// Fin de sonnerie
[_id] spawn {
    params ["_id"];
    sleep ((getNumber (missionConfigFile >> "PHN_Settings" >> "callRingSeconds")) max 5);
    private _r = PHN_calls getOrDefault [format ["c%1", _id], []];
    if (_r isNotEqualTo [] && {(_r select 2) == "ringing"}) then { [_id, "Pas de réponse."] call PHN_fnc_srvEndCall; };
};
