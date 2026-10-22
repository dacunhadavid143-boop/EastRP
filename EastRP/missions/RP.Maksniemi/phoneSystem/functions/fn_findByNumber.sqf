/* SERVEUR : joueur connecté ayant ce numéro (objNull si injoignable). params: [numéro] */
params ["_num"];
private _l = allPlayers select { (_x getVariable ["CORE_active", false]) && {([_x, "phone", ""] call CORE_fnc_getValue) == _num} };
if (_l isEqualTo []) then { objNull } else { _l select 0 }
