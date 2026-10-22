/* SERVEUR : événement CORE_playerLoaded [unit, uid] (connexion ou réapparition) : hors service, étape 1, synchronisation.
   Un éventuel ancien véhicule de service du joueur (avant sa mort / reconnexion) est rangé. */
params ["_unit"];
_unit setVariable ["JOB_duty", false];
_unit setVariable ["JOB_step", 0];
_unit setVariable ["JOB_penalty", false];
if (!isNil "JOB_vehs") then {
    private _uid = getPlayerUID _unit;
    { if ((_x getVariable ["JOB_owner", ""]) == _uid) then { _unit setVariable ["JOB_veh", _x]; [_unit] call JOB_fnc_srvVehClear; }; } forEach +JOB_vehs;
};
[_unit] call JOB_fnc_srvAssign;
[_unit] call JOB_fnc_srvSync;
