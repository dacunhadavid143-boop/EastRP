/* Rectangle à coins arrondis, fait de bandes horizontales. Coordonnées ABSOLUES (unités d'interface).
   params: [x, y, w, h, rayon en pixels, couleur, couleurBas (optionnel : dégradé vertical), nombre max de bandes par coin (48 par défaut)]. Renvoie un tableau de contrôles. */
params ["_ax", "_ay", "_aw", "_ah", "_r", ["_c1", [1,1,1,1]], ["_c2", []], ["_maxN", 48]];
private _d = uiNamespace getVariable "PHN_display";
private _pw = pixelW;
private _ph = pixelH;
private _out = [];
private _grad = _c2 isNotEqualTo [];
_r = (_r min ((_aw / 2) / _pw)) min ((_ah / 2) / _ph);
private _ov = if ((_c1 select 3) >= 0.99) then { 1.7 } else { 1 };   // léger recouvrement si opaque (évite les fines lignes)

private _mk = {
    params ["_sy", "_shh", "_inset", "_t"];
    private _c = _d ctrlCreate ["PHN_RscText", -1];
    _c ctrlSetPosition [_ax + _inset, _sy, _aw - 2 * _inset, _shh];
    _c ctrlSetBackgroundColor (if (_grad) then { [_c1, _c2, _t] call PHN_fnc_lerpColor } else { _c1 });
    _c ctrlCommit 0;
    _out pushBack _c;
};

if (_r < 1.5) exitWith {
    [_ay, _ah, 0, 0.5] call _mk;
    _out
};

private _rx = _r * _pw;
private _ry = _r * _ph;
private _n = ((floor _r) min _maxN) max 1;
private _st = _ry / _n;

for "_k" from 0 to (_n - 1) do {                                    // coins du haut
    private _rho = (_n - _k - 0.5) / _n;
    [_ay + _k * _st, _st * _ov, _rx * (1 - sqrt (1 - _rho * _rho)), ((_k + 0.5) * _st) / _ah] call _mk;
};

private _midH = _ah - 2 * _ry;                                       // milieu
if (_midH > 0) then {
    if (_grad) then {
        private _m = (floor (_midH / (_ph * 4))) max 1 min 140;
        private _ms = _midH / _m;
        for "_j" from 0 to (_m - 1) do {
            [_ay + _ry + _j * _ms, _ms * _ov, 0, (_ry + (_j + 0.5) * _ms) / _ah] call _mk;
        };
    } else {
        [_ay + _ry, _midH, 0, 0.5] call _mk;
    };
};

for "_k" from 0 to (_n - 1) do {                                    // coins du bas
    private _rho = (_k + 0.5) / _n;
    [_ay + _ah - _ry + _k * _st, _st * _ov, _rx * (1 - sqrt (1 - _rho * _rho)), (_ah - _ry + (_k + 0.5) * _st) / _ah] call _mk;
};
_out
