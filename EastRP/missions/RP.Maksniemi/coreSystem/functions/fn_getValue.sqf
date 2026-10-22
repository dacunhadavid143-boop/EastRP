/* SERVEUR : lit une valeur du joueur (stockée et sauvegardée avec ses données). params: [unit, clé, défaut] */
if (!isServer) exitWith {};
params ["_unit", "_key", ["_def", 0]];
private _hm = CORE_sessions getOrDefault [getPlayerUID _unit, createHashMap];
if (count _hm == 0) exitWith { _def };
_hm getOrDefault [_key, _def]
