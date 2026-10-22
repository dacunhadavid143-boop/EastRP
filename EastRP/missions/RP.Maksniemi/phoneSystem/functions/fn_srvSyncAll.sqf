/* SERVEUR : envoie au client (propriétaire uniquement) numéro, messages, journal bancaire, rôle. params: [unit] */
if (!isServer) exitWith {};
params ["_unit"];
private _o = owner _unit;
private _r = [_unit] call PHN_fnc_srvRole;
_unit setVariable ["PHN_number",   [_unit, "phone", ""] call CORE_fnc_getValue, _o];
private _bl = [_unit, "bankLog", []] call CORE_fnc_getValue;
if !(_bl isEqualType []) then {
    diag_log format ["[PHN] journal bancaire invalide (type %1) pour %2, remis à zéro", typeName _bl, name _unit];
    _bl = [];
    [_unit, "bankLog", _bl] call CORE_fnc_setValue;
};
_unit setVariable ["CORE_bankLog", _bl, _o];
_unit setVariable ["PHN_roleName", _r select 0, _o];
_unit setVariable ["PHN_perms",    _r select 1, _o];
