/* Interpolation de couleur. params: [c1, c2, t(0..1)] */
params ["_a", "_b", "_t"];
_t = (_t max 0) min 1;
[
    (_a select 0) + ((_b select 0) - (_a select 0)) * _t,
    (_a select 1) + ((_b select 1) - (_a select 1)) * _t,
    (_a select 2) + ((_b select 2) - (_a select 2)) * _t,
    (_a select 3) + ((_b select 3) - (_a select 3)) * _t
]
