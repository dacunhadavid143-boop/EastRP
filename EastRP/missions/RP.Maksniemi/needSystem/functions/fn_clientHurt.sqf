/* CLIENT : dégâts de privation (faim/soif à 0), envoyés par le serveur. params: [dégâts] */
params ["_d"];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
if (alive player) then { player setDamage (((damage player) + _d) min 1); };
