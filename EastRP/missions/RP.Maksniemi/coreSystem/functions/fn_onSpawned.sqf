/* Événement SPN_spawned : demande au serveur de charger les données. params: [unit, pointId] */
params ["_unit"];
[_unit, CORE_firstSpawn] remoteExec ["CORE_fnc_srvLoadPlayer", 2];
