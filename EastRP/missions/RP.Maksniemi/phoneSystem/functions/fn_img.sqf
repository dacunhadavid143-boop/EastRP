/* Chemin d'une image du téléphone (fichier .paa dans phoneSystem\img), ou "" si elle n'existe pas. params: [nom sans extension]
   Essaie le chemin complet de la mission puis le chemin relatif ; note dans le .rpt chaque image introuvable (une seule fois). */
params ["_name"];
if (isNil "PHN_imgCache") then { PHN_imgCache = createHashMap; };
private _c = PHN_imgCache getOrDefault [_name, "?"];
if (_c != "?") exitWith { _c };
private _rel = format ["phoneSystem\img\%1.paa", _name];
private _full = getMissionPath _rel;
private _res = "";
if (fileExists _full) then { _res = _full; } else { if (fileExists _rel) then { _res = _rel; }; };
if (_res == "") then { diag_log format ["[PHN] image INTROUVABLE : %1 (cherchée : %2)", _name, _full]; };
PHN_imgCache set [_name, _res];
_res
