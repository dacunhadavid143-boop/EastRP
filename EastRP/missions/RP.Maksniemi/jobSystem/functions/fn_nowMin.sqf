/* SERVEUR : heure réelle en minutes depuis le 01/01/2025 (UTC). Sert aux délais en temps réel (carence après démission). */
(systemTimeUTC select [0, 6]) params ["_y", "_mo", "_d", "_h", "_mi", "_sec"];
private _yy = if (_mo <= 2) then { _y - 1 } else { _y };
private _era = floor (_yy / 400);
private _yoe = _yy - _era * 400;
private _mp = (_mo + 9) mod 12;
private _doy = floor ((153 * _mp + 2) / 5) + _d - 1;
private _doe = _yoe * 365 + floor (_yoe / 4) - floor (_yoe / 100) + _doy;
private _days = _era * 146097 + _doe - 719468 - 20089;    // 20089 = jours entre 1970 et 2025
_days * 1440 + _h * 60 + _mi + _sec / 60
