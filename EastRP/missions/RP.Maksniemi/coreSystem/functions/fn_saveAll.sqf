/* SERVEUR : capture + sauvegarde de tous les joueurs actifs */
if (!isServer) exitWith {};
{ [_x] call CORE_fnc_capture; } forEach allPlayers;
{ [_x] call CORE_fnc_savePlayer; } forEach (keys CORE_sessions);
if (CORE_dirty) then { saveProfileNamespace; CORE_dirty = false; };
diag_log format ["[CORE] Sauvegarde automatique : %1 joueur(s)", count CORE_sessions];
