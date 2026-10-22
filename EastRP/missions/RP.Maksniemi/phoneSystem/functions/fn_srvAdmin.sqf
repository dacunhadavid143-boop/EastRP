/* SERVEUR : actions d'administration. Le rôle du joueur est VÉRIFIÉ ici (le client n'est jamais cru). params: [unit, action, arguments] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_act", "", [""]], ["_args", [], [[]]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};

private _perm = switch (_act) do {
    case "money":   { "money" };
    case "item":    { "item" };
    case "arsenal": { "arsenal" };
    case "god":     { "god" };
    case "heal";
    case "needs":   { "heal" };
    case "tp_to";
    case "tp_bring";
    case "tp_pos":  { "tp" };
    default         { "" };
};
private _msg = { params ["_m"]; [_m] remoteExec ["CORE_fnc_clientMsg", _unit]; };
if (_perm == "" || {!([_unit, _perm] call PHN_fnc_hasPerm)}) exitWith {
    diag_log format ["[PHN][ADMIN] REFUSÉ : %1 (%2) action=%3", name _unit, getPlayerUID _unit, _act];
    ["[Admin] Permission refusée."] call _msg;
};
diag_log format ["[PHN][ADMIN] %1 (%2) : %3 %4", name _unit, getPlayerUID _unit, _act, _args];

private _tgOk = { params ["_t"]; _t isEqualType objNull && {!isNull _t} && {isPlayer _t} };

switch (_act) do {
    case "money": {
        _args params [["_tg", objNull], ["_amt", 0, [0]]];
        if (!([_tg] call _tgOk) || {floor _amt == 0}) exitWith { ["[Admin] Paramètres invalides."] call _msg; };
        private _ok = [_tg, "cash", floor _amt] call CORE_fnc_changeMoney;
        [format ["[Admin] Argent %1 pour %2.", if (_ok) then { "modifié" } else { "inchangé (solde insuffisant ou limite)" }, name _tg]] call _msg;
    };
    case "item": {
        _args params [["_tg", objNull], ["_cls", "", [""]], ["_qty", 1, [0]]];
        if (!([_tg] call _tgOk) || {_cls == ""} || {count _cls > 80}) exitWith { ["[Admin] Paramètres invalides."] call _msg; };
        ["item", [_cls, _qty]] remoteExec ["PHN_fnc_clientAdmin", _tg];
    };
    case "arsenal": { ["arsenal", []] remoteExec ["PHN_fnc_clientAdmin", _unit]; };
    case "god": {
        _args params [["_s", false, [false]]];
        ["god", [_s]] remoteExec ["PHN_fnc_clientAdmin", _unit];
    };
    case "heal": {
        _args params [["_tg", objNull]];
        if !([_tg] call _tgOk) exitWith { ["[Admin] Cible invalide."] call _msg; };
        ["heal", []] remoteExec ["PHN_fnc_clientAdmin", _tg];
        [_tg, "hunger", 100] call CORE_fnc_setValue;
        [_tg, "thirst", 100] call CORE_fnc_setValue;
        if (!isNil "NEED_fnc_sync") then { [_tg] call NEED_fnc_sync; };
    };
    case "needs": {
        _args params [["_tg", objNull], ["_d", 0, [0]]];
        if !([_tg] call _tgOk) exitWith { ["[Admin] Cible invalide."] call _msg; };
        {
            [_tg, _x, ((([_tg, _x, 100] call CORE_fnc_getValue) + _d) min 100) max 0] call CORE_fnc_setValue;
        } forEach ["hunger", "thirst"];
        if (!isNil "NEED_fnc_sync") then { [_tg] call NEED_fnc_sync; };
    };
    case "tp_to": {
        _args params [["_tg", objNull]];
        if !([_tg] call _tgOk) exitWith { ["[Admin] Cible invalide."] call _msg; };
        ["tp", [getPosATL _tg]] remoteExec ["PHN_fnc_clientAdmin", _unit];
    };
    case "tp_bring": {
        _args params [["_tg", objNull]];
        if !([_tg] call _tgOk) exitWith { ["[Admin] Cible invalide."] call _msg; };
        ["tp", [getPosATL _unit]] remoteExec ["PHN_fnc_clientAdmin", _tg];
    };
    case "tp_pos": {
        _args params [["_p", [], [[]]]];
        if (count _p < 2 || {_p findIf { !(_x isEqualType 0) } != -1}) exitWith { ["[Admin] Position invalide."] call _msg; };
        ["tp", [[_p select 0, _p select 1, 0]]] remoteExec ["PHN_fnc_clientAdmin", _unit];
    };
};
