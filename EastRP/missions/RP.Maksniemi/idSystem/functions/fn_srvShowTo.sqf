/* SERVEUR : un joueur montre ses papiers à un joueur proche. Les données viennent du serveur (le client ne peut pas mentir).
   params: [unit, cible, "id"|"licence"] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_tg", objNull, [objNull]], ["_type", "id", [""]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
private _dev = getNumber (missionConfigFile >> "CORE_Settings" >> "devMode") == 1;     // en devMode, on peut se montrer ses propres papiers (test en solo)
if (isNull _tg || {!isPlayer _tg} || {_tg == _unit && !_dev}) exitWith {};
if !(_type in ["id", "licence"]) exitWith {};
if ((_unit distance _tg) > 6) exitWith { ["[Papiers] Cette personne est trop loin."] remoteExec ["CORE_fnc_clientMsg", _unit]; };
private _d = profileNamespace getVariable [format ["DOC_id_%1", getPlayerUID _unit], []];
if (_d isEqualTo []) exitWith {};
if (_type == "licence" && {(_d select 11) == ""}) exitWith { ["[Papiers] Vous n'avez pas de permis."] remoteExec ["CORE_fnc_clientMsg", _unit]; };
[_type, _d, _unit] remoteExec ["DOC_fnc_clientShowFrom", _tg];
[format ["[Papiers] Vous montrez votre %1 à %2.", if (_type == "id") then { "carte d'identité" } else { "permis" }, name _tg]] remoteExec ["CORE_fnc_clientMsg", _unit];
