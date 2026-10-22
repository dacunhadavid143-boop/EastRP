/* CLIENT : application « Emploi » du téléphone */
[[0.07, 0.07, 0.09, 1]] call PHN_fnc_uiAppBg;
["Emploi"] call PHN_fnc_uiHeader;
private _card = [0.13, 0.14, 0.17, 1];
private _orange = [0.95, 0.55, 0.12, 1];
private _s = player getVariable ["JOB_state", []];
private _row = {
    params ["_y", "_k", "_v", ["_col", [1,1,1,1]]];
    [0.04, _y, 0.92, 0.085, _card, 14] call PHN_fnc_uiRect;
    [0.07, _y + 0.008, 0.86, 0.03, _k, 0.020, [1,1,1,0.5]] call PHN_fnc_uiText;
    [0.07, _y + 0.038, 0.86, 0.04, _v, 0.027, _col, "left", "PuristaBold"] call PHN_fnc_uiText;
};
if (count _s == 0 || {(_s select 0) == ""}) exitWith {
    [0.04, 0.10, 0.92, 0.05, "Sans emploi", 0.036, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
    [0.04, 0.155, 0.92, 0.04, "Signez un contrat au Pôle Emploi.", 0.024, [1,1,1,0.6]] call PHN_fnc_uiText;
    private _xpList = if (count _s > 0) then { _s select 11 } else { [] };
    private _y = 0.23;
    {
        private _id = configName _x;
        private _i = _xpList findIf { _x isEqualType [] && {(_x select 0) == _id} };
        private _xp = if (_i < 0) then { 0 } else { (_xpList select _i) select 1 };
        private _lv = [_id, _xp] call JOB_fnc_cfgLevel;
        [_y, getText (_x >> "displayName"), format ["Niveau %1 - %2 (%3 XP)", _lv select 0, getText ((_lv select 1) >> "title"), _xp]] call _row;
        _y = _y + 0.095;
    } forEach ("true" configClasses (missionConfigFile >> "JOB_Jobs"));
    if (count _s > 0 && {(_s select 12) > 0}) then {
        [0.04, _y + 0.01, 0.92, 0.04, format ["Nouvelle inscription possible dans %1", [(_s select 12) * 60] call JOB_fnc_fmtDur], 0.022, _orange] call PHN_fnc_uiText;
    };
};

private _sym = getText (missionConfigFile >> "CORE_Settings" >> "currencySymbol");
[0.04, 0.09, 0.92, 0.05, _s select 16, 0.032, [1,1,1,1], "left", "PuristaBold"] call PHN_fnc_uiText;
[0.04, 0.14, 0.92, 0.04, format ["Niveau %1 : %2", _s select 1, _s select 2], 0.026, _orange, "left", "PuristaBold"] call PHN_fnc_uiText;

// Barre d'expérience
private _xp = _s select 3;
private _next = _s select 4;
private _prev = getNumber (((([_s select 0, _xp] call JOB_fnc_cfgLevel)) select 1) >> "xpRequired");
private _p = if (_next < 0) then { 1 } else { ((_xp - _prev) / ((_next - _prev) max 1)) min 1 max 0 };
[0.04, 0.195, 0.92, 0.022, [1,1,1,0.12], 6] call PHN_fnc_uiRect;
if (_p > 0.01) then { [0.04, 0.195, 0.92 * _p, 0.022, _orange, 6] call PHN_fnc_uiRect; };
[0.04, 0.222, 0.92, 0.035, if (_next < 0) then { format ["%1 XP - niveau maximum", _xp] } else { format ["%1 / %2 XP pour le niveau suivant", _xp, _next] }, 0.020, [1,1,1,0.6]] call PHN_fnc_uiText;

private _left = (_s select 10) - (_s select 9);
[0.28, "Service", if (_s select 8) then { "En service" } else { "Hors service" }, if (_s select 8) then { [0.30, 0.85, 0.45, 1] } else { [1,1,1,0.7] }] call _row;
[0.375, "Tâche en cours", if (_s select 8) then { format ["%1 (étape %2/%3)", _s select 6, (_s select 5) + 1, _s select 15] } else { "Prenez votre service sur le lieu de travail" }] call _row;
[0.47, "Salaire par tâche", format ["%1 %2 (versé sur votre compte)", _s select 17, _sym]] call _row;
[0.565, "Contrat minimum", if (_left > 0) then { format ["%1 / %2 effectués", [_s select 9] call JOB_fnc_fmtDur, [_s select 10] call JOB_fnc_fmtDur] } else { "Effectué : démission possible" }] call _row;
[0.04, 0.665, 0.92, 0.06, "Démission : au Pôle Emploi. XP conservée par métier.", 0.019, [1,1,1,0.45]] call PHN_fnc_uiText;
