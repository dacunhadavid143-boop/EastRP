/* SERVEUR : événement CORE_playerLoaded [unit, uid] : attribue un numéro de téléphone si besoin et synchronise */
if (!isServer) exitWith {};
params ["_unit"];
private _n = [_unit, "phone", ""] call CORE_fnc_getValue;
if (_n == "") then {
    private _gen = {
        private _s = format ["%1", 5 + floor random 5];
        for "_i" from 1 to 6 do { _s = _s + str (floor random 10); };
        _s
    };
    _n = call _gen;
    while { _n in PHN_used } do { _n = call _gen; };
    PHN_used pushBack _n;
    profileNamespace setVariable ["PHN_usedNumbers", PHN_used];
    [_unit, "phone", _n] call CORE_fnc_setValue;
    diag_log format ["[PHN] Numéro %1 attribué à %2", _n, name _unit];
};
// Messages du chat reçus pendant l'absence du joueur (file d'attente)
private _qk = format ["PHN_q_%1", _n];
private _q = profileNamespace getVariable [_qk, []];
if (_q isNotEqualTo []) then {
    private _m = [_unit, "wa_msgs", []] call CORE_fnc_getValue;
    { _x set [5, 1]; _m pushBack _x; } forEach _q;
    if (count _m > 200) then { _m = _m select [(count _m) - 200, 200]; };
    [_unit, "wa_msgs", _m] call CORE_fnc_setValue;
    profileNamespace setVariable [_qk, nil];
    if (!isNil "CORE_dirty") then { CORE_dirty = true; };
    { [_x select 2, _x select 0, 1] call PHN_fnc_srvWaSetStatus; } forEach _q;
};
[_unit] call PHN_fnc_srvSyncAll;
[_unit] call PHN_fnc_srvWaSync;
