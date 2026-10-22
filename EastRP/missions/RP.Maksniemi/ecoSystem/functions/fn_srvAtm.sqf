/* SERVEUR : opération au distributeur. Le serveur re-vérifie tout (distance, objet, solde). params: [unit, distributeur, "deposit"|"withdraw", montant] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_atm", objNull, [objNull]], ["_op", "", [""]], ["_amt", 0, [0]]];
private _ro = remoteExecutedOwner;
private _dbgOn = getNumber (missionConfigFile >> "ECO_Settings" >> "debug") == 1;
private _dbg = {
    params ["_m"];
    if (_dbgOn) then {
        diag_log format ["[ECO] srvAtm : %1", _m];
        if (!isNull _unit) then { [format ["[ECO debug] %1", _m]] remoteExec ["CORE_fnc_clientMsg", _unit]; };
    };
};
if (isNull _unit || {!isPlayer _unit}) exitWith { ["refus : joueur invalide"] call _dbg; };
if (_ro != 0 && {_ro != owner _unit}) exitWith { [format ["refus : expéditeur %1 différent du propriétaire %2", _ro, owner _unit]] call _dbg; };
if !(_unit getVariable ["CORE_active", false]) exitWith { ["refus : joueur non actif (CORE_active = false)"] call _dbg; };
private _msg = { params ["_m"]; [_m] remoteExec ["CORE_fnc_clientMsg", _unit]; };
[format ["reçu : %1 %2 | distributeur=%3 classe=%4", _op, _amt, _atm, typeOf _atm]] call _dbg;
if (isNull _atm || {!([_atm] call ECO_fnc_isAtm)}) exitWith { ["[Distributeur] Distributeur introuvable."] call _msg; ["refus : objet inconnu ou pas un distributeur"] call _dbg; };
private _d = [_atm, _unit] call ECO_fnc_boxDist;
if (_d > getNumber (missionConfigFile >> "ECO_Settings" >> "atmDistance")) exitWith { ["[Distributeur] Vous êtes trop loin."] call _msg; [format ["refus : distance %1 m", round _d]] call _dbg; };
_amt = floor _amt;
if (_amt < 1 || {_amt > getNumber (missionConfigFile >> "ECO_Settings" >> "atmMaxPerOperation")}) exitWith { ["[Distributeur] Montant invalide ou trop élevé."] call _msg; ["refus : montant invalide"] call _dbg; };
private _sym = getText (missionConfigFile >> "CORE_Settings" >> "currencySymbol");

switch (_op) do {
    case "deposit": {
        if ([_unit, "cash", -_amt] call CORE_fnc_changeMoney) then {
            [_unit, "bank", _amt] call CORE_fnc_changeMoney;
            [format ["[Distributeur] %1 %2 déposés.", _amt, _sym]] call _msg;
            ["succès : dépôt"] call _dbg;
            if (!isNil "PHN_fnc_srvLog") then { [_unit, "Dépôt (distributeur)", _amt] call PHN_fnc_srvLog; };
        } else { ["[Distributeur] Espèces insuffisantes."] call _msg; ["refus : espèces insuffisantes"] call _dbg; };
    };
    case "withdraw": {
        if ([_unit, "bank", -_amt] call CORE_fnc_changeMoney) then {
            [_unit, "cash", _amt] call CORE_fnc_changeMoney;
            [format ["[Distributeur] %1 %2 retirés.", _amt, _sym]] call _msg;
            ["succès : retrait"] call _dbg;
            if (!isNil "PHN_fnc_srvLog") then { [_unit, "Retrait (distributeur)", -_amt] call PHN_fnc_srvLog; };
        } else { ["[Distributeur] Solde insuffisant."] call _msg; ["refus : solde insuffisant"] call _dbg; };
    };
    default { [format ["refus : opération inconnue '%1'", _op]] call _dbg; };
};
