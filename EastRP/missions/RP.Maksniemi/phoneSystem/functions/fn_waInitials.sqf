/* Initiales d'un nom. params: [nom] */
params ["_n"];
_n = (_n splitString "~()[]{}<>-_.,:;!?""'/") joinString " ";
private _w = (_n splitString " ") select { _x != "" };
if (_w isEqualTo []) exitWith { "?" };
private _a = toUpper ((_w select 0) select [0, 1]);
if (count _w > 1) then { _a + toUpper ((_w select 1) select [0, 1]) } else { _a }
