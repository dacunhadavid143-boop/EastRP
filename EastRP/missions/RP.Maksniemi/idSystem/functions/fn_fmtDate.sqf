/* [j,m,a] -> "JJ.MM.AAAA" */
params ["_d"];
private _pad = { params ["_n"]; if (_n < 10) then { format ["0%1", _n] } else { format ["%1", _n] } };
format ["%1.%2.%3", [_d select 0] call _pad, [_d select 1] call _pad, _d select 2]
