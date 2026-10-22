/* Heure du JEU "HH:MM" (la même que l'horloge du téléphone) */
private _t = daytime;
private _h = floor _t;
private _m = floor ((_t - _h) * 60);
private _p = { params ["_n"]; if (_n < 10) then { format ["0%1", _n] } else { format ["%1", _n] } };
format ["%1:%2", [_h] call _p, [_m] call _p]
