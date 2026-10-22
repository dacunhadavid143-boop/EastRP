/* SERVEUR : relève l'état physique d'un joueur (équipement, position) dans sa session. params: [unit] */
if (!isServer) exitWith {};
params ["_unit"];
if (isNull _unit || {!alive _unit} || {!(_unit getVariable ["CORE_active", false])}) exitWith {};
private _hm = CORE_sessions getOrDefault [getPlayerUID _unit, createHashMap];
if (count _hm == 0) exitWith {};
_hm set ["loadout", getUnitLoadout _unit];
_hm set ["pos", getPosATL _unit];
_hm set ["dir", getDir _unit];
