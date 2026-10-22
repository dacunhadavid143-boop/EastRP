/* Formate un nombre : 1234567 -> "1 234 567". params: [nombre] */
params ["_n"];
private _s = _n toFixed 0;
private _len = count _s;
private _out = "";
for "_i" from 0 to (_len - 1) do {
    _out = _out + (_s select [_i, 1]);
    if (((_len - _i - 1) mod 3) == 0 && {_i < _len - 1} && {(_s select [_i, 1]) != "-"}) then { _out = _out + " "; };
};
_out
