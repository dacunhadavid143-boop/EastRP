/* SERVEUR : met à jour l'annuaire et les statuts de tous les joueurs connectés */
if (!isServer) exitWith {};
{ [_x] call PHN_fnc_srvWaPushOne; } forEach (allPlayers select { _x getVariable ["CORE_active", false] });
