/* SPN_fnc_confirm : valide le spawn. À appeler avec spawn. */
if (SPN_busy) exitWith {};
private _p = SPN_points select 0;
if !([_p] call SPN_fnc_canSpawn) exitWith { systemChat "[SPN] Spawn impossible."; };
SPN_busy = true;

closeDialog 1;

// Étapes obligatoires avant le spawn (ex: formulaire d'identité). Un hook renvoyant false annule.
private _go = true;
{
    private _r = [_p] call _x;
    if (isNil "_r" || {!(_r isEqualType true)} || {!_r}) exitWith { _go = false; };
} forEach SPN_preSpawnHooks;

if (!_go) exitWith {
    SPN_busy = false;
    createDialog "SPN_Dialog";        // retour à l'écran de spawn
};

private _cfg = missionConfigFile >> "SPN_Settings";
private _pos = _p select 3;
private _dir = _p select 4;

cutText ["", "BLACK OUT", 0.6];
uiSleep 0.8;
call SPN_fnc_camStop;

private _unit = player;
if (getNumber (_cfg >> "createNewUnit") == 1) then {
    private _old = player;
    private _grp  = createGroup [side group _old, true];
    _unit = _grp createUnit [getText (_cfg >> "unitClass"), _pos, [], 0, "NONE"];
    _unit setPosATL _pos;
    _unit setDir _dir;
    selectPlayer _unit;
    deleteVehicle _old;
} else {
    _unit setPosATL _pos;
    _unit setDir _dir;
};

_unit allowDamage true;
SPN_isOpen = false;
cutText ["", "BLACK IN", 2];

[missionNamespace, "SPN_spawned", [_unit, _p select 0]] call BIS_fnc_callScriptedEventHandler;
