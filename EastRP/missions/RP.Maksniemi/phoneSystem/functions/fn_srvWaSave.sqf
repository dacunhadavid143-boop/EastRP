/* SERVEUR : sauvegarde des profils et statuts du chat (profils enregistrés en paires [[numéro, profil], ...]) */
if (!isServer) exitWith {};
private _pairs = [];
{ _pairs pushBack [_x, _y]; } forEach PHN_profiles;
profileNamespace setVariable ["PHN_wa_profiles", _pairs];
profileNamespace setVariable ["PHN_wa_status", PHN_statuses];
if (!isNil "CORE_dirty") then { CORE_dirty = true; };
