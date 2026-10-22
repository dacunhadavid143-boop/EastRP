/* Nom affiché d'une application enregistrée. params: [id] */
params ["_id"];
private _i = PHN_apps findIf { (_x select 0) == _id };
if (_i < 0) then { _id } else { (PHN_apps select _i) select 1 }
