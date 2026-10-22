/* CLIENT : applique l'équipement et la position sauvegardés (envoyés par le serveur). params: [loadout, position, direction] */
params [["_lo", []], ["_pos", []], ["_dir", 0]];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
if (_lo isNotEqualTo []) then { player setUnitLoadout _lo; };
if (count _pos == 3) then { player setPosATL _pos; player setDir _dir; };
// Les autres modules (ex: documents d'identité) peuvent réagir
[missionNamespace, "CORE_loadoutApplied", [player]] call BIS_fnc_callScriptedEventHandler;
