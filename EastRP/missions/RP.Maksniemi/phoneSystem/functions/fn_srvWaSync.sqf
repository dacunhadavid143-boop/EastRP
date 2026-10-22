/* SERVEUR : envoie au joueur son état du chat (inscription, messages, contacts, annuaire, statuts). params: [unit] */
if (!isServer) exitWith {};
params ["_unit"];
private _o = owner _unit;
_unit setVariable ["PHN_waReg",      [_unit, "wa_reg", false] call CORE_fnc_getValue, _o];
_unit setVariable ["PHN_waMsgs",     [_unit, "wa_msgs", []] call CORE_fnc_getValue, _o];
_unit setVariable ["PHN_waContacts", [_unit, "wa_contacts", []] call CORE_fnc_getValue, _o];
[_unit] call PHN_fnc_srvWaPushOne;
