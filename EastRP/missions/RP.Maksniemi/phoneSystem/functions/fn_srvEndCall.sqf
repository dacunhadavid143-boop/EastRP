/* SERVEUR (interne) : termine un appel et libère le canal. params: [idAppel, raison] */
if (!isServer) exitWith {};
params ["_id", "_reason"];
private _key = format ["c%1", _id];
private _rec = PHN_calls getOrDefault [_key, []];
if (_rec isEqualTo []) exitWith {};
_rec params ["_a", "_b", "_state", "_ch"];
if (_ch >= 0) then {
    _ch radioChannelRemove [_a, _b];
    private _i = PHN_pool findIf { (_x select 0) == _ch };
    if (_i >= 0) then { (PHN_pool select _i) set [1, false]; };
};
{
    if (!isNull _x) then {
        _x setVariable ["PHN_callId", -1];
        ["ended", [_reason]] remoteExec ["PHN_fnc_clientCall", _x];
    };
} forEach [_a, _b];
PHN_calls deleteAt _key;
