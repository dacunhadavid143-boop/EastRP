/* SERVEUR : envoie l'argent au client propriétaire uniquement. params: [unit] */
if (!isServer) exitWith {};
params ["_unit"];
private _hm = CORE_sessions getOrDefault [getPlayerUID _unit, createHashMap];
if (count _hm == 0) exitWith {};
private _o = owner _unit;
_unit setVariable ["CORE_cash", _hm get "cash", _o];
_unit setVariable ["CORE_bank", _hm get "bank", _o];
