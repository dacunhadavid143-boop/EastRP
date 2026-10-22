/* SERVEUR : opérations bancaires du téléphone : VIREMENTS uniquement. (Dépôt et retrait d'espèces : réservés aux distributeurs, futur module.) params: [unit, "transfer", montant, cible] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_op", "", [""]], ["_amt", 0, [0]], ["_tg", objNull, [objNull]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
_amt = floor _amt;
if (_amt < 1 || {_amt > 1000000000}) exitWith {};

private _msg = { params ["_m", "_u"]; [_m] remoteExec ["CORE_fnc_clientMsg", _u]; };
private _sym = getText (missionConfigFile >> "CORE_Settings" >> "currencySymbol");

switch (_op) do {
    case "transfer": {
        if (isNull _tg || {!isPlayer _tg} || {_tg == _unit} || {!(_tg getVariable ["CORE_active", false])}) exitWith { ["[Banque] Destinataire invalide.", _unit] call _msg; };
        if ([_unit, "bank", -_amt] call CORE_fnc_changeMoney) then {
            if ([_tg, "bank", _amt] call CORE_fnc_changeMoney) then {
                [_unit, format ["Virement vers %1", name _tg], -_amt] call PHN_fnc_srvLog;
                [_tg, format ["Virement de %1", name _unit], _amt] call PHN_fnc_srvLog;
                [format ["[Banque] Vous avez reçu %1 %2 de %3.", _amt, _sym, name _unit], _tg] call _msg;
                [format ["[Banque] Virement de %1 %2 envoyé à %3.", _amt, _sym, name _tg], _unit] call _msg;
            } else {
                [_unit, "bank", _amt] call CORE_fnc_changeMoney;    // remboursement
                ["[Banque] Virement impossible.", _unit] call _msg;
            };
        } else { ["[Banque] Solde insuffisant.", _unit] call _msg; };
    };
};
