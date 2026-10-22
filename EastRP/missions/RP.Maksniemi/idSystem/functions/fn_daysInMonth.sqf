/* params: [mois(1-12), année] */
params ["_m", "_y"];
private _leap = (_y mod 4 == 0 && {_y mod 100 != 0}) || {_y mod 400 == 0};
if (_m == 2) exitWith { if (_leap) then {29} else {28} };
if (_m in [4,6,9,11]) exitWith {30};
31
