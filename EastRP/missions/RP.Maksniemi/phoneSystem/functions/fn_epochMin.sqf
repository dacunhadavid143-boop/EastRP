/* Minutes écoulées depuis le 01.01.2020 (heure réelle), pour dater les messages et statuts. */
private _t = systemTime;
private _leap = { params ["_y"]; (_y mod 4 == 0 && {_y mod 100 != 0}) || {_y mod 400 == 0} };
private _days = 0;
for "_y" from 2020 to ((_t select 0) - 1) do { _days = _days + (if ([_y] call _leap) then { 366 } else { 365 }); };
private _dm = [31, if ([_t select 0] call _leap) then { 29 } else { 28 }, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
for "_m" from 0 to ((_t select 1) - 2) do { _days = _days + (_dm select _m); };
_days = _days + ((_t select 2) - 1);
_days * 1440 + (_t select 3) * 60 + (_t select 4)
