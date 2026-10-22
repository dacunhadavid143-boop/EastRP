/* "HH:MM" si aujourd'hui, "Hier", sinon "il y a N j". params: [minutes depuis 2020] */
params ["_e"];
private _now = call PHN_fnc_epochMin;
private _d = (floor (_now / 1440)) - (floor (_e / 1440));
private _p = { params ["_n"]; if (_n < 10) then { format ["0%1", _n] } else { format ["%1", _n] } };
if (_d <= 0) exitWith { format ["%1:%2", [floor ((_e mod 1440) / 60)] call _p, [_e mod 60] call _p] };
if (_d == 1) exitWith { "Hier" };
format ["il y a %1 j", _d]
