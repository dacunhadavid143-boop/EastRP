/* Application Téléphone : clavier */
if ((PHN_call select 0) != "idle") exitWith { [PHN_fnc_pgCall, []] call PHN_fnc_showPage; };
["Téléphone", true] call PHN_fnc_uiHeader;
private _d = [0, 0.09, 1, 0.08, [PHN_dial] call PHN_fnc_fmtPhone, 0.06, [1,1,1,1], "center", "PuristaBold"] call PHN_fnc_uiText;
PHN_refs set ["dial", _d];

private _c = PHN_C;
private _fw = 0.22;
private _fh = [_fw] call PHN_fnc_squareH;
private _rad = 0.5 * (_fw * (_c select 2)) / pixelW;
private _keys = ["1","2","3","4","5","6","7","8","9","*","0","#"];
{
    private _col = _forEachIndex mod 3;
    private _row = floor (_forEachIndex / 3);
    [0.09 + _col * 0.30, 0.22 + _row * (_fh + 0.025), _fw, _fh, _x, [1,1,1,0.18], [1,1,1,1], {
        params ["_k"];
        if (count PHN_dial < 10) then {
            PHN_dial = PHN_dial + _k;
            (PHN_refs get "dial") ctrlSetText ([PHN_dial] call PHN_fnc_fmtPhone);
        };
    }, _x, _rad, 0.05] call PHN_fnc_uiButton;
} forEach _keys;

private _y = 0.22 + 4 * (_fh + 0.025);
[0.39, _y, _fw, _fh, "Appeler", [0.20,0.78,0.35,1], [1,1,1,1], {
    if (count PHN_dial < 3) exitWith { systemChat "[Téléphone] Numéro trop court."; };
    [player, PHN_dial] remoteExec ["PHN_fnc_srvCall", 2];
}, [], _rad, 0.026] call PHN_fnc_uiButton;
[0.68, _y, 0.28, _fh, "Effacer", [0,0,0,0], [1,1,1,0.8], {
    if (count PHN_dial > 0) then {
        PHN_dial = PHN_dial select [0, (count PHN_dial) - 1];
        (PHN_refs get "dial") ctrlSetText ([PHN_dial] call PHN_fnc_fmtPhone);
    };
}, [], 0, 0.028] call PHN_fnc_uiButton;
