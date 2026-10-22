/* "Ivan Petrov" -> ["Ivan","Petrov"]. [] si le nom n'est pas au format Prénom Nom */
params [["_n", ""]];
private _p = _n splitString " ";
if (count _p < 2) exitWith { [] };
[_p select 0, (_p select [1, count _p - 1]) joinString " "]
