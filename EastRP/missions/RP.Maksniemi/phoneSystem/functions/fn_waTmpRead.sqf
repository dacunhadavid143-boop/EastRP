/* Mémorise dans PHN_waTmp ce qui est saisi dans les champs de la page (nom, info). */
private _n = PHN_refs getOrDefault ["name", controlNull];
private _a = PHN_refs getOrDefault ["about", controlNull];
if (!isNull _n) then { PHN_waTmp set [1, ctrlText _n]; };
if (!isNull _a) then { PHN_waTmp set [3, ctrlText _a]; };
