/* Profil [nom, avatar, info] d'un numéro (annuaire reçu du serveur), ou [] si inconnu. params: [numéro] */
params ["_num"];
private _i = (player getVariable ["PHN_waDir", []]) findIf { (_x select 0) == _num };
if (_i < 0) then { [] } else { private _e = (player getVariable ["PHN_waDir", []]) select _i; [_e select 1, _e select 2, _e select 3] }
