/* Niveau atteint dans un métier selon l'expérience. params: [métier, xp]
   -> [numéro de niveau (1..n), config du niveau, xp requise pour le niveau suivant (-1 si niveau max)] */
params ["_job", ["_xp", 0]];
private _lv = "true" configClasses (missionConfigFile >> "JOB_Jobs" >> _job >> "Levels");
if (_lv isEqualTo []) exitWith { [0, configNull, -1] };
private _idx = 0;
{ if (_xp >= getNumber (_x >> "xpRequired")) then { _idx = _forEachIndex; }; } forEach _lv;
private _next = if (_idx + 1 < count _lv) then { getNumber ((_lv select (_idx + 1)) >> "xpRequired") } else { -1 };
[_idx + 1, _lv select _idx, _next]
