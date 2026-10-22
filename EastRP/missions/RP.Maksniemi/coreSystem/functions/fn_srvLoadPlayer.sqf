/* SERVEUR : charge (ou crée) les données d'un joueur après son spawn. params: [unit, premierSpawn] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_first", false]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith { diag_log "[CORE] srvLoadPlayer refusé (propriétaire)"; };

private _uid = getPlayerUID _unit;
private _cfg = missionConfigFile >> "CORE_Settings";
private _hm = CORE_sessions getOrDefault [_uid, createHashMap];

if (count _hm == 0) then {
    _hm = createHashMapFromArray ([_uid] call CORE_fnc_dbLoad);
    {
        private _k = _x select 0;
        if !(_k in _hm) then { _hm set [_k, _x select 1]; };
    } forEach [
        ["cash",  getNumber (_cfg >> "startCash")],
        ["bank",  getNumber (_cfg >> "startBank")],
        ["loadout", []],
        ["pos", []],
        ["dir", 0]
    ];
    CORE_sessions set [_uid, _hm];
    [_uid] call CORE_fnc_savePlayer;
    diag_log format ["[CORE] Données chargées pour %1 (%2)", name _unit, _uid];
};

_unit setVariable ["CORE_active", true];
[_unit] call CORE_fnc_sync;

// Reconnexion : on rend au joueur son équipement et sa position
if (_first && {getNumber (_cfg >> "restoreOnLogin") == 1}) then {
    private _lo  = _hm getOrDefault ["loadout", []];
    private _pos = _hm getOrDefault ["pos", []];
    if (_lo isNotEqualTo [] || {_pos isNotEqualTo []}) then {
        [_lo, _pos, _hm getOrDefault ["dir", 0]] remoteExec ["CORE_fnc_clientApply", _unit];
    };
};

[missionNamespace, "CORE_playerLoaded", [_unit, _uid]] call BIS_fnc_callScriptedEventHandler;
