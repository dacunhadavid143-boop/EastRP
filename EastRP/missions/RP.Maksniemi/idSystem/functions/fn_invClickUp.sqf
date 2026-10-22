/* EH display "MouseButtonUp" : détecte soi-même un double-clic (deux clics rapprochés sur le même objet) */
params ["_disp", "_btn"];
if (_btn != 0) exitWith { false };
private _s = [_disp] call DOC_fnc_selClass;
private _cls = _s select 2;
private _now = diag_tickTime;
private _last = DOC_lastClick;
DOC_lastClick = [_now, _cls, _s select 0];
["Clic idc=" + str (ctrlIDC (_s select 0)) + " classe='" + _cls + "'"] call DOC_fnc_dbg;
if (_cls != "" && {_now - (_last select 0) < 0.5} && {(_last select 1) == _cls}) exitWith {
    [_disp, _cls] call DOC_fnc_invUse
};
false
