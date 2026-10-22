/* SERVEUR : écrit une valeur du joueur (sauvegardée avec ses données). params: [unit, clé, valeur]. true si OK */
if (!isServer) exitWith { false };
params ["_unit", "_key", "_value"];
private _hm = CORE_sessions getOrDefault [getPlayerUID _unit, createHashMap];
if (count _hm == 0) exitWith { false };
_hm set [_key, _value];
true
