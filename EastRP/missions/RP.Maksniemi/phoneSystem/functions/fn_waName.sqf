/* Nom affiché pour un numéro : contact enregistré, sinon "~nom du profil", sinon numéro. params: [numéro] */
params ["_num"];
private _ci = (player getVariable ["PHN_waContacts", []]) findIf { (_x select 0) == _num };
if (_ci >= 0) exitWith { ((player getVariable ["PHN_waContacts", []]) select _ci) select 1 };
private _p = [_num] call PHN_fnc_waProfileOf;
if (_p isNotEqualTo []) exitWith { "~" + (_p select 0) };
[_num] call PHN_fnc_fmtPhone
