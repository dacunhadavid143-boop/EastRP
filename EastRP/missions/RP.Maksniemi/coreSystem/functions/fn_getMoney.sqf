/* SERVEUR : lit l'argent. params: [unit, "cash"|"bank"] -> nombre (0 si inconnu) */
if (!isServer) exitWith { 0 };
params ["_unit", "_key"];
private _hm = CORE_sessions getOrDefault [getPlayerUID _unit, createHashMap];
if (count _hm == 0) exitWith { 0 };
_hm getOrDefault [_key, 0]
