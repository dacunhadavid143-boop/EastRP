/* SERVEUR : un joueur demande à jouer une animation de travail ; le serveur la diffuse à tous les joueurs. params: [unit, animation ("" = fin)] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_anim", "", [""]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if (_anim != "" && {!isClass (configFile >> "CfgMovesMaleSdr" >> "States" >> _anim)}) exitWith {};
[_unit, _anim] remoteExec ["JOB_fnc_clientAnim", -(owner _unit)];   // tous sauf le joueur lui-même (il la joue déjà en local)
