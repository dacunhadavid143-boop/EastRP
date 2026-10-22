/* Chat : nouvelle discussion / contacts */
[PHN_wBg] call PHN_fnc_uiAppBg;
[0, 0.012, 1, 0.05, "Nouvelle discussion", 0.034, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
[0.02, 0.012, 0.3, 0.05, "< Retour", [0,0,0,0], PHN_wGreen, { [PHN_fnc_pgWaChats, []] call PHN_fnc_showPage; }, [], 0, 0.028] call PHN_fnc_uiButton;

[0.05, 0.095, 0.9, 0.035, "Ajouter un contact", 0.022, PHN_wGray] call PHN_fnc_uiText;
[0.05, 0.13, 0.42, 0.058, "", 0.026, "cn"] call PHN_fnc_uiEdit;
[0.51, 0.13, 0.44, 0.058, "", 0.026, "cname"] call PHN_fnc_uiEdit;
[0.05, 0.188, 0.42, 0.03, "Numéro (7 chiffres)", 0.018, PHN_wGray] call PHN_fnc_uiText;
[0.51, 0.188, 0.44, 0.03, "Nom", 0.018, PHN_wGray] call PHN_fnc_uiText;
[0.05, 0.225, 0.9, 0.058, "Ajouter et discuter", PHN_wGreen, [0.04, 0.08, 0.10, 1], {
    private _n = ctrlText (PHN_refs getOrDefault ["cn", controlNull]);
    private _nm = ctrlText (PHN_refs getOrDefault ["cname", controlNull]);
    if (count _n != 7 || {_nm == ""}) exitWith { systemChat "[Chat] Numéro (7 chiffres) et nom requis."; };
    [player, _n, _nm] remoteExec ["PHN_fnc_srvWaContact", 2];
    [_n] spawn { params ["_n"]; uiSleep 0.7; if (PHN_open) then { [PHN_fnc_pgWaChat, [_n]] call PHN_fnc_showPage; }; };
}, [], 16, 0.028] call PHN_fnc_uiButton;

private _my = player getVariable ["PHN_number", ""];
private _list = [];
{ _list pushBack [_x select 0, _x select 1, "contact"]; } forEach (player getVariable ["PHN_waContacts", []]);
{
    private _n = _x select 0;
    if (_n != _my && {_list findIf { (_x select 0) == _n } < 0}) then { _list pushBack [_n, "~" + (_x select 1), "annuaire"]; };
} forEach (player getVariable ["PHN_waDir", []]);

[0.05, 0.31, 0.9, 0.035, "Contacts", 0.022, PHN_wGray] call PHN_fnc_uiText;
private _y = 0.345;
{
    if (_forEachIndex < 5) then {
        _x params ["_num", "_name"];
        private _p = [_num] call PHN_fnc_waProfileOf;
        [0.04, _y + 0.008, 0.12, if (_p isEqualTo []) then { 6 } else { _p select 1 }, [_name] call PHN_fnc_waInitials] call PHN_fnc_uiAvatar;
        [0.20, _y + 0.010, 0.7, 0.036, _name, 0.028, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
        [0.20, _y + 0.048, 0.7, 0.03, [_num] call PHN_fnc_fmtPhone, 0.021, PHN_wGray] call PHN_fnc_uiText;
        [0.0, _y, 1, 0.095, "", [0,0,0,0], [1,1,1,1], { [PHN_fnc_pgWaChat, [_this select 0]] call PHN_fnc_showPage; }, _num, 0, 0.02] call PHN_fnc_uiButton;
        _y = _y + 0.103;
    };
} forEach _list;
if (_list isEqualTo []) then { [0.05, 0.40, 0.9, 0.04, "Aucun contact pour l'instant.", 0.024, PHN_wGray, "center"] call PHN_fnc_uiText; };
