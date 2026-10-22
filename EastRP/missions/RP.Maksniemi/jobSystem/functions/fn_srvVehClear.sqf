/* SERVEUR : range (supprime) le véhicule de service d'un joueur : fin de service, démission, promotion, déconnexion.
   Les occupants sont d'abord descendus du véhicule. params: [unit] */
params ["_unit"];
private _v = _unit getVariable ["JOB_veh", objNull];
_unit setVariable ["JOB_veh", objNull];
if (isNull _v) exitWith {};
JOB_vehs = JOB_vehs - [_v];
{ [_v] remoteExec ["JOB_fnc_clientEject", _x]; } forEach ((crew _v) select { isPlayer _x });
[_v] spawn { params ["_v"]; sleep 1.5; { if (!isPlayer _x) then { deleteVehicle _x; }; } forEach crew _v; deleteVehicle _v; };
