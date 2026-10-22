/* SERVEUR : sauvegarde un joueur en session. params: [uid]
   Format enregistré : liste de paires [[clé, valeur], ...] (relue par createHashMapFromArray). */
if (!isServer) exitWith {};
params ["_uid"];
private _hm = CORE_sessions getOrDefault [_uid, createHashMap];
if (count _hm == 0) exitWith {};
private _pairs = [];
{ _pairs pushBack [_x, _y]; } forEach _hm;
[_uid, _pairs] call CORE_fnc_dbSave;
