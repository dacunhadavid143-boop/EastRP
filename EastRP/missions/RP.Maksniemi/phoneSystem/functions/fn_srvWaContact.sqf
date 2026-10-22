/* SERVEUR : ajoute ou renomme un contact. params: [unit, numéro, nom] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_num", "", [""]], ["_name", "", [""]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
if (count _num != 7 || {((toArray _num) findIf { _x < 48 || _x > 57 }) != -1}) exitWith {};
_name = [_name, 25] call PHN_fnc_cleanText;
_name = ((_name splitString " ") select { _x != "" }) joinString " ";
if (_name == "") exitWith {};
private _c = [_unit, "wa_contacts", []] call CORE_fnc_getValue;
_c = _c select { (_x select 0) != _num };
_c pushBack [_num, _name];
if (count _c > 100) then { _c = _c select [(count _c) - 100, 100]; };
[_unit, "wa_contacts", _c] call CORE_fnc_setValue;
_unit setVariable ["PHN_waContacts", _c, owner _unit];
