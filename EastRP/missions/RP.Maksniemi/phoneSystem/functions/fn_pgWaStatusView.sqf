/* Chat : lecture d'un statut. params: [numéro] */
params ["_num"];
private _c = PHN_C;
private _i = (player getVariable ["PHN_waStatus", []]) findIf { (_x select 0) == _num };
if (_i < 0) exitWith { [PHN_fnc_pgWaStatus, []] call PHN_fnc_showPage; };
private _st = (player getVariable ["PHN_waStatus", []]) select _i;
private _col = PHN_wStCols select ((_st select 2) mod 6);
[_col] call PHN_fnc_uiAppBg;

private _p = [_num] call PHN_fnc_waProfileOf;
private _name = [_num] call PHN_fnc_waName;
[0.04, 0.012, 0.11, if (_p isEqualTo []) then { 6 } else { _p select 1 }, [_name] call PHN_fnc_waInitials] call PHN_fnc_uiAvatar;
[0.19, 0.012, 0.6, 0.04, _name, 0.030, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
[0.19, 0.052, 0.6, 0.03, [_st select 3] call PHN_fnc_waTimeLabel, 0.021, [1,1,1,0.75]] call PHN_fnc_uiText;
[0.78, 0.014, 0.20, 0.06, "Fermer", [0,0,0,0], [1,1,1,1], { [PHN_fnc_pgWaStatus, []] call PHN_fnc_showPage; }, [], 0, 0.026] call PHN_fnc_uiButton;

private _s = (uiNamespace getVariable "PHN_display") ctrlCreate ["PHN_RscStruct", -1];
_s ctrlSetPosition [(_c select 0) + 0.08 * (_c select 2), (_c select 1) + 0.25 * (_c select 3), 0.84 * (_c select 2), 0.45 * (_c select 3)];
_s ctrlSetStructuredText parseText format ["<t align='center' size='%2'>%1</t>", [_st select 1] call PHN_fnc_esc, (_c select 3) / 0.42];
_s ctrlCommit 0;
PHN_page pushBack _s;
