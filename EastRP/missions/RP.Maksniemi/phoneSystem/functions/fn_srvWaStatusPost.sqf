/* SERVEUR : publie (ou remplace) le statut texte du joueur, valable 24 h. params: [unit, texte, couleur(0-5)] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_text", "", [""]], ["_col", 0, [0]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
if !([_unit, "wa_reg", false] call CORE_fnc_getValue) exitWith {};
_text = [_text, 140] call PHN_fnc_cleanText;
if ((_text splitString " ") isEqualTo []) exitWith {};
private _my = [_unit, "phone", ""] call CORE_fnc_getValue;
PHN_statuses = PHN_statuses select { (_x select 0) != _my };
PHN_statuses pushBack [_my, _text, ((floor _col) max 0) min 5, call PHN_fnc_epochMin];
call PHN_fnc_srvWaSave;
call PHN_fnc_srvWaPush;
