/* Image à une position ABSOLUE. params: [x, y, w, h, nom, teinte]. Renvoie le contrôle (controlNull si l'image n'existe pas). */
params ["_ax", "_ay", "_aw", "_ah", "_name", ["_tint", [1,1,1,1]]];
private _p = [_name] call PHN_fnc_img;
if (_p == "") exitWith { controlNull };
private _c = (uiNamespace getVariable "PHN_display") ctrlCreate ["PHN_RscPicture", -1];
_c ctrlSetPosition [_ax, _ay, _aw, _ah];
_c ctrlSetText _p;
_c ctrlSetTextColor _tint;
_c ctrlCommit 0;
_c
