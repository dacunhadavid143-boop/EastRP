/* SERVEUR : sort le véhicule de service du niveau (classe "vehicle" du niveau) pour un joueur.
   Il apparaît sur un marqueur de stationnement libre (préfixe "vehicleSpawn", ex : job_elec_parking_1), sinon près du point.
   params: [unit, point de l'étape, config du niveau] -> true si le joueur a un véhicule */
params ["_unit", "_mk", "_lc"];
private _old = _unit getVariable ["JOB_veh", objNull];
if (alive _old) exitWith { true };
if (!isNull _old) then { deleteVehicle _old; };
private _cls = getText (_lc >> "vehicle");
if !(isClass (configFile >> "CfgVehicles" >> _cls)) then {
    diag_log format ["[JOB] véhicule '%1' introuvable dans les mods chargés : remplacé par %2 (à corriger dans settings.hpp)", _cls, getText (missionConfigFile >> "JOB_Settings" >> "vehFallback")];
    _cls = getText (missionConfigFile >> "JOB_Settings" >> "vehFallback");
};
private _base = [_mk] call JOB_fnc_pointPos;
private _pos = [];
private _dir = _unit getDir _base;
private _pref = getText (_lc >> "vehicleSpawn");
if (_pref != "") then {
    private _free = ([_pref] call JOB_fnc_pointList) select {
        count (([_x] call JOB_fnc_pointPos) nearEntities [["LandVehicle", "Air", "Ship", "Man"], 4]) == 0
    };
    if (count _free > 0) then {
        _free = [_free, [_base], { _input0 distance2D ([_x] call JOB_fnc_pointPos) }, "ASCEND"] call BIS_fnc_sortBy;
        private _p = _free select 0;
        _pos = [_p] call JOB_fnc_pointPos;
        _dir = if (getMarkerType _p != "") then { markerDir _p } else { getDir (missionNamespace getVariable [_p, objNull]) };
    } else {
        if (count ([_pref] call JOB_fnc_pointList) > 0) exitWith { _pos = [-1]; };   // places existantes mais toutes occupées
    };
};
if (_pos isEqualTo [-1]) exitWith { false };
if (_pos isEqualTo []) then {
    _pos = _base findEmptyPosition [6, 40, _cls];
    if (_pos isEqualTo []) then { _pos = _base getPos [12, random 360]; };
};
private _v = createVehicle [_cls, [_pos select 0, _pos select 1, 0], [], 0, "NONE"];
_v setDir _dir;
_v setPosATL [_pos select 0, _pos select 1, 0.15];
clearItemCargoGlobal _v; clearWeaponCargoGlobal _v; clearMagazineCargoGlobal _v; clearBackpackCargoGlobal _v;
_v setVariable ["JOB_owner", getPlayerUID _unit, true];
_v setVariable ["JOB_ownerName", name _unit, true];
_unit setVariable ["JOB_veh", _v];
JOB_vehs pushBack _v;
diag_log format ["[JOB] véhicule de service %1 sorti pour %2", _cls, name _unit];
true
