/* SERVEUR : fait baisser la faim et la soif de tous les joueurs actifs */
if (!isServer) exitWith {};
private _cfg = missionConfigFile >> "NEED_Settings";
private _sec = (getNumber (_cfg >> "tickSeconds")) max 5;
private _dH = (getNumber (_cfg >> "hungerPerMinute")) * _sec / 60;
private _dT = (getNumber (_cfg >> "thirstPerMinute")) * _sec / 60;
private _dmg = getNumber (_cfg >> "starvationDamage");
{
    if ((_x getVariable ["CORE_active", false]) && {alive _x}) then {
        private _h = (([_x, "hunger", 100] call CORE_fnc_getValue) - _dH) max 0;
        private _w = (([_x, "thirst", 100] call CORE_fnc_getValue) - _dT) max 0;
        [_x, "hunger", _h] call CORE_fnc_setValue;
        [_x, "thirst", _w] call CORE_fnc_setValue;
        [_x] call NEED_fnc_sync;
        if ((_h <= 0 || _w <= 0) && {_dmg > 0}) then { [_dmg] remoteExec ["NEED_fnc_clientHurt", _x]; };
    };
} forEach allPlayers;
