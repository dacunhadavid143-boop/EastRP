/* SERVEUR : achat en boutique. Prix et catalogue viennent du serveur, jamais du client. params: [unit, boutique, identifiant article, quantité] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_shop", objNull, [objNull]], ["_id", "", [""]], ["_qty", 1, [0]]];
private _ro = remoteExecutedOwner;
private _dbgOn = getNumber (missionConfigFile >> "ECO_Settings" >> "debug") == 1;
private _dbg = {
    params ["_m"];
    if (_dbgOn) then {
        diag_log format ["[ECO] srvBuy : %1", _m];
        if (!isNull _unit) then { [format ["[ECO debug] %1", _m]] remoteExec ["CORE_fnc_clientMsg", _unit]; };
    };
};
if (isNull _unit || {!isPlayer _unit}) exitWith { ["refus : joueur invalide"] call _dbg; };
if (_ro != 0 && {_ro != owner _unit}) exitWith { [format ["refus : expéditeur %1 différent du propriétaire %2", _ro, owner _unit]] call _dbg; };
if !(_unit getVariable ["CORE_active", false]) exitWith { ["refus : joueur non actif (CORE_active = false)"] call _dbg; };
private _msg = { params ["_m"]; [_m] remoteExec ["CORE_fnc_clientMsg", _unit]; };
private _type = [_shop] call ECO_fnc_shopType;
[format ["reçu : article=%1 x%2 | boutique=%3 classe=%4 type='%5'", _id, _qty, _shop, typeOf _shop, _type]] call _dbg;
if (_type == "") exitWith { ["[Boutique] Boutique introuvable."] call _msg; ["refus : type de boutique inconnu"] call _dbg; };
private _d = [_shop, _unit] call ECO_fnc_boxDist;
if (_d > getNumber (missionConfigFile >> "ECO_Settings" >> "shopDistance")) exitWith { ["[Boutique] Vous êtes trop loin."] call _msg; [format ["refus : distance %1 m", round _d]] call _dbg; };
private _cfg = missionConfigFile >> "ECO_Shops" >> _type >> "Items" >> _id;
if (!isClass _cfg) exitWith { ["[Boutique] Article inconnu."] call _msg; ["refus : article inconnu dans ce catalogue"] call _dbg; };
_qty = ((floor _qty) max 1) min 20;
private _price = getNumber (_cfg >> "price");
private _total = _price * _qty;
private _sym = getText (missionConfigFile >> "CORE_Settings" >> "currencySymbol");
if !([_unit, "cash", -_total] call CORE_fnc_changeMoney) exitWith { [format ["[Boutique] Espèces insuffisantes (%1 %2 requis).", _total, _sym]] call _msg; ["refus : espèces insuffisantes"] call _dbg; };
[getText (_cfg >> "item"), _qty, getText (_cfg >> "displayName")] remoteExec ["ECO_fnc_clientGive", _unit];
[format ["[Boutique] Achat : %1 x%2 (-%3 %4)", getText (_cfg >> "displayName"), _qty, _total, _sym]] call _msg;
["succès"] call _dbg;
diag_log format ["[ECO] %1 achète %2 x%3 pour %4", name _unit, _id, _qty, _total];
