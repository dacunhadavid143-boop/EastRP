/* SERVEUR : le joueur a ouvert la discussion : ses messages reçus passent à "lu" (coches bleues chez l'expéditeur). params: [unit, numéro de l'interlocuteur] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_other", "", [""]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_unit getVariable ["CORE_active", false]) exitWith {};
private _my = [_unit, "phone", ""] call CORE_fnc_getValue;
private _m = [_unit, "wa_msgs", []] call CORE_fnc_getValue;
private _ids = [];
{
    if ((_x select 2) == _other && {(_x select 3) == _my} && {(_x select 5) < 2}) then {
        _x set [5, 2];
        _ids pushBack (_x select 0);
    };
} forEach _m;
if (_ids isEqualTo []) exitWith {};
[_unit, "wa_msgs", _m] call CORE_fnc_setValue;
_unit setVariable ["PHN_waMsgs", _m, owner _unit];
{ [_other, _x, 2] call PHN_fnc_srvWaSetStatus; } forEach _ids;
