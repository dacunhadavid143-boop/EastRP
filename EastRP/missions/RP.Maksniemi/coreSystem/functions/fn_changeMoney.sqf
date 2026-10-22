/* SERVEUR : modifie l'argent. params: [unit, "cash"|"bank", delta(+/-)]. Renvoie true si OK, false si impossible (solde insuffisant, etc.) */
if (!isServer) exitWith { false };
params ["_unit", "_key", "_delta"];
if !(_key in ["cash", "bank"]) exitWith { false };
if !(_delta isEqualType 0) exitWith { false };
_delta = floor _delta;
if (_delta == 0) exitWith { false };
private _hm = CORE_sessions getOrDefault [getPlayerUID _unit, createHashMap];
if (count _hm == 0) exitWith { false };
private _new = (_hm get _key) + _delta;
if (_new < 0 || {_new > 1000000000}) exitWith { false };
_hm set [_key, _new];
[_unit] call CORE_fnc_sync;
CORE_flushSoon = true;   // l'argent a changé : écriture sur le disque dans les 2 secondes (voir CORE_fnc_init)
true
