/* Réglages : numéro, touche d'ouverture, fond d'écran */
["Réglages", true] call PHN_fnc_uiHeader;
[0.04, 0.10, 0.92, 0.075, [1,1,1,0.12], 12] call PHN_fnc_uiRect;
[0.07, 0.112, 0.5, 0.04, "Mon numéro", 0.026, [1,1,1,0.7]] call PHN_fnc_uiText;
[0.45, 0.112, 0.48, 0.04, [player getVariable ["PHN_number", ""]] call PHN_fnc_fmtPhone, 0.028, [1,1,1,1], "right", "PuristaBold"] call PHN_fnc_uiText;

[0.04, 0.20, 0.92, 0.075, [1,1,1,0.12], 12] call PHN_fnc_uiRect;
[0.07, 0.212, 0.5, 0.04, "Touche d'ouverture", 0.026, [1,1,1,0.7]] call PHN_fnc_uiText;
private _k = [0.45, 0.212, 0.48, 0.04, if (PHN_capture) then { "Appuyez sur une touche..." } else { keyName PHN_key }, 0.028, [1,1,1,1], "right", "PuristaBold"] call PHN_fnc_uiText;
[0.04, 0.29, 0.92, 0.065, "Modifier la touche", [0.30,0.62,1,1], [1,1,1,1], {
    PHN_capture = true;
    [] call PHN_fnc_refresh;
}, [], 12, 0.028] call PHN_fnc_uiButton;
[0.04, 0.36, 0.92, 0.04, "Échap ou Entrée pour annuler la modification.", 0.02, [1,1,1,0.45], "center"] call PHN_fnc_uiText;

[0.04, 0.44, 0.6, 0.04, "Fond d'écran", 0.026, [1,1,1,0.7]] call PHN_fnc_uiText;
private _walls = [
    [[0.07,0.09,0.30,1], [0.50,0.20,0.58,1]],
    [[0.04,0.22,0.34,1], [0.10,0.58,0.52,1]],
    [[0.28,0.07,0.10,1], [0.90,0.48,0.22,1]]
];
private _fw = 0.26;
private _fh = [_fw] call PHN_fnc_squareH;
{
    [0.04 + _forEachIndex * 0.33, 0.49, _fw, _fh * 1.4, _x select 0, 12, _x select 1] call PHN_fnc_uiRect;
    [0.04 + _forEachIndex * 0.33, 0.49, _fw, _fh * 1.4, "", [0,0,0,0], [1,1,1,1], {
        PHN_wall = _this select 0;
        profileNamespace setVariable ["PHN_wall", PHN_wall];
        saveProfileNamespace;
        closeDialog 0;
        [] spawn { uiSleep 0.15; [] call PHN_fnc_open; };
    }, _forEachIndex, 12, 0.02] call PHN_fnc_uiButton;
} forEach _walls;
private _st = call PHN_fnc_imgStatus;
_st params ["_ok", "_tot", "_miss"];
if (_ok < _tot) then { diag_log format ["[PHN] images manquantes (%1/%2) : %3", _ok, _tot, _miss]; };
[0.04, 0.93, 0.92, 0.04, "Téléphone v1.0", 0.02, [1,1,1,0.35], "center"] call PHN_fnc_uiText;
