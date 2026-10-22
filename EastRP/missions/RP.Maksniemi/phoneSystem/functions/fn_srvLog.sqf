/* SERVEUR : ajoute une ligne au journal bancaire du joueur. params: [unit, texte, montant(+/-)] */
if (!isServer) exitWith {};
params ["_unit", "_text", "_amt"];
private _log = [_unit, "bankLog", []] call CORE_fnc_getValue;
if !(_log isEqualType []) then {
    // valeur invalide (ancienne sauvegarde) : on repart d'un journal vide
    diag_log format ["[PHN] journal bancaire invalide (type %1) pour %2, remis à zéro : %3", typeName _log, name _unit, _log];
    _log = [];
};
_log pushBack [[] call PHN_fnc_nowStr, _text, _amt];
if (count _log > 12) then { _log = _log select [(count _log) - 12, 12]; };
[_unit, "bankLog", _log] call CORE_fnc_setValue;
_unit setVariable ["CORE_bankLog", _log, owner _unit];
