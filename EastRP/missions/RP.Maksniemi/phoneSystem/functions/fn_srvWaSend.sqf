/* SERVEUR : envoi d'un message du chat (livré tout de suite si le destinataire est connecté, sinon mis en file d'attente). params: [unit, numéro, texte] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_to", "", [""]], ["_text", "", [""]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
if !([_unit, "wa_reg", false] call CORE_fnc_getValue) exitWith {};
if (time < (_unit getVariable ["PHN_next", 0])) exitWith {};
_unit setVariable ["PHN_next", time + 0.5];
if (count _to != 7 || {((toArray _to) findIf { _x < 48 || _x > 57 }) != -1}) exitWith {};
_text = [_text, 300] call PHN_fnc_cleanText;
if ((_text splitString " ") isEqualTo []) exitWith {};
private _my = [_unit, "phone", ""] call CORE_fnc_getValue;
if (_to == _my) exitWith {};
if !(_to in PHN_profiles) exitWith { ["[Chat] Ce numéro n'utilise pas l'application."] remoteExec ["CORE_fnc_clientMsg", _unit]; };

private _id = "";
for "_i" from 1 to 12 do { _id = _id + str (floor random 10); };
private _entry = [_id, call PHN_fnc_epochMin, _my, _to, _text, 0];
private _cap = 200;
private _add = {
    params ["_u", "_e"];
    private _m = [_u, "wa_msgs", []] call CORE_fnc_getValue;
    _m pushBack _e;
    if (count _m > _cap) then { _m = _m select [(count _m) - _cap, _cap]; };
    [_u, "wa_msgs", _m] call CORE_fnc_setValue;
    _u setVariable ["PHN_waMsgs", _m, owner _u];
};

private _rec = [_to] call PHN_fnc_findByNumber;
if (!isNull _rec) then {
    _entry set [5, 1];                                   // distribué
    [_rec, +_entry] call _add;
    [_my, _text, true] remoteExec ["PHN_fnc_clientWaIn", _rec];
} else {
    private _k = format ["PHN_q_%1", _to];               // file d'attente jusqu'à sa prochaine connexion
    private _q = profileNamespace getVariable [_k, []];
    _q pushBack (+_entry);
    if (count _q > _cap) then { _q = _q select [(count _q) - _cap, _cap]; };
    profileNamespace setVariable [_k, _q];
    if (!isNil "CORE_dirty") then { CORE_dirty = true; };
};
[_unit, _entry] call _add;
["", "", false] remoteExec ["PHN_fnc_clientWaIn", _unit];
