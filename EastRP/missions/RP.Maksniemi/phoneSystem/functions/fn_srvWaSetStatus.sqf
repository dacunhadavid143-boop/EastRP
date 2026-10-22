/* SERVEUR : met à jour l'état d'un message (1 = distribué, 2 = lu) dans la liste d'un joueur connecté. params: [numéro, idMessage, état] */
if (!isServer) exitWith {};
params ["_num", "_id", "_st"];
private _u = [_num] call PHN_fnc_findByNumber;
if (isNull _u) exitWith {};
private _m = [_u, "wa_msgs", []] call CORE_fnc_getValue;
private _i = _m findIf { (_x select 0) == _id };
if (_i >= 0 && {((_m select _i) select 5) < _st}) then {
    (_m select _i) set [5, _st];
    [_u, "wa_msgs", _m] call CORE_fnc_setValue;
    _u setVariable ["PHN_waMsgs", _m, owner _u];
    ["", "", false] remoteExec ["PHN_fnc_clientWaIn", _u];
};
