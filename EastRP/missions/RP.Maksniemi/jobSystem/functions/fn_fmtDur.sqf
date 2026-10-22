/* Durée lisible. params: [secondes] -> "1 h 05" ou "12 min" */
params [["_s", 0]];
private _m = floor (_s / 60);
if (_m < 60) exitWith { format ["%1 min", _m] };
private _r = _m mod 60;
format ["%1 h %2", floor (_m / 60), if (_r < 10) then { format ["0%1", _r] } else { str _r }]
