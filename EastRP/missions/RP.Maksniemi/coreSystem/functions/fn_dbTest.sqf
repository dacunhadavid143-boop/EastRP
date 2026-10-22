/* SERVEUR : test de connexion à la base via extDB3. Écrit les résultats dans le .rpt (lignes "[CORE][DB]"). */
if (!isServer) exitWith {};
private _name = getText (missionConfigFile >> "CORE_Settings" >> "dbName");
private _log = { params ["_m"]; diag_log ("[CORE][DB] " + _m); };

["=== Test de la base de données ==="] call _log;

private _v = "extDB3" callExtension "9:VERSION";
[format ["Version extDB3 : '%1'  (vide = extension non chargée)", _v]] call _log;
if (_v == "") exitWith { ["ECHEC : extDB3 non chargée. Vérifie MODS=@Maksniemi;@extDB3 dans config.bat et le dossier @extDB3."] call _log; };

private _r1 = "extDB3" callExtension format ["9:ADD_DATABASE:%1", _name];
[format ["ADD_DATABASE (%1) -> %2", _name, _r1]] call _log;

private _r2 = "extDB3" callExtension format ["9:ADD_DATABASE_PROTOCOL:%1:SQL:SQL", _name];
[format ["ADD_DATABASE_PROTOCOL -> %1", _r2]] call _log;

private _r3 = "extDB3" callExtension "0:SQL:SELECT 1";
[format ["SELECT 1 -> %1", _r3]] call _log;

private _r4 = "extDB3" callExtension "0:SQL:SELECT COUNT(*) FROM players";
[format ["SELECT COUNT(*) FROM players -> %1", _r4]] call _log;

["=== Fin du test ==="] call _log;
