/* SERVEUR : modification du profil du chat. params: [unit, nom, avatar, info] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_name", "", [""]], ["_av", 0, [0]], ["_about", "", [""]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
if !([_unit, "wa_reg", false] call CORE_fnc_getValue) exitWith {};
private _my = [_unit, "phone", ""] call CORE_fnc_getValue;
_name = [_name, 25] call PHN_fnc_cleanText;
_name = ((_name splitString " ") select { _x != "" }) joinString " ";
_about = [_about, 80] call PHN_fnc_cleanText;
if (_name == "") exitWith {};
if (_about == "") then { _about = "Disponible"; };
_av = ((floor _av) max 0) min 7;
PHN_profiles set [_my, [_name, _av, _about]];
call PHN_fnc_srvWaSave;
call PHN_fnc_srvWaPush;
