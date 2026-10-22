/* SERVEUR : le joueur utilise un consommable. params: [unit, classe]. Le serveur vérifie que l'objet est bien dans son inventaire. */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_cls", "", [""]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith { diag_log "[NEED] srvConsume refusé (propriétaire)"; };

private _dbg = getNumber (missionConfigFile >> "NEED_Settings" >> "debug") == 1;
private _say = {
    params ["_m"];
    diag_log ("[NEED] " + _m);
    if (_dbg) then { ["[NEED debug] " + _m] remoteExec ["CORE_fnc_clientMsg", _unit]; };
};
[format ["demande reçue : %1", _cls]] call _say;

if (!(_unit getVariable ["CORE_active", false]) || {!alive _unit}) exitWith { ["refus : joueur non chargé par le noyau (CORE_active faux)"] call _say; };

private _c = missionConfigFile >> "NEED_CfgConsumables" >> _cls;
if (!isClass _c) exitWith { [format ["refus : '%1' n'est pas un consommable déclaré", _cls]] call _say; };
if (time < (_unit getVariable ["NEED_next", 0])) exitWith {};
_unit setVariable ["NEED_next", time + 1.5];

private _lc = toLower _cls;
private _have = ((magazines _unit) + (items _unit)) apply { toLower _x };
diag_log format ["[NEED] %1 utilise %2 (dans l'inventaire : %3)", name _unit, _cls, _lc in _have];
if !(_lc in _have) exitWith {
    ["refus : objet introuvable dans l'inventaire vu par le serveur"] call _say;
    ["[NEED] Objet introuvable dans votre inventaire."] remoteExec ["CORE_fnc_clientMsg", _unit];
};

private _h = [_unit, "hunger", 100] call CORE_fnc_getValue;
private _w = [_unit, "thirst", 100] call CORE_fnc_getValue;
private _addH = getNumber (_c >> "hunger");
private _addW = getNumber (_c >> "thirst");

// Rien à gagner : on ne consomme pas l'objet
if ((_addH <= 0 || {_h >= 100}) && {_addW <= 0 || {_w >= 100}}) exitWith {
    [format ["refus : rien à gagner (faim %1, soif %2)", round _h, round _w]] call _say;
    ["[NEED] Vous n'en avez pas besoin pour le moment."] remoteExec ["CORE_fnc_clientMsg", _unit];
};

[_unit, "hunger", (_h + _addH) min 100] call CORE_fnc_setValue;
[_unit, "thirst", (_w + _addW) min 100] call CORE_fnc_setValue;
[_unit] call NEED_fnc_sync;
[configName _c, getText (_c >> "displayName")] remoteExec ["NEED_fnc_clientConsumed", _unit];
CORE_flushSoon = true;   // inventaire modifié : sauvegarde rapide (voir CORE_fnc_init)
["consommation validée"] call _say;
