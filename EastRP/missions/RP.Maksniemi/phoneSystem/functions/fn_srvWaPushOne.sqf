/* SERVEUR : envoie à un joueur l'annuaire des profils et les statuts non expirés. params: [unit] */
if (!isServer) exitWith {};
params ["_unit"];
private _now = call PHN_fnc_epochMin;
PHN_statuses = PHN_statuses select { (_now - (_x select 3)) < 1440 };
private _dir = (keys PHN_profiles) apply { [_x] + (PHN_profiles get _x) };
private _o = owner _unit;
_unit setVariable ["PHN_waDir", _dir, _o];
_unit setVariable ["PHN_waStatus", PHN_statuses, _o];
