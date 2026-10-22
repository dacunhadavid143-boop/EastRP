/* ENREGISTRER UNE APPLICATION (appelable par n'importe quel module).
   params: [id, nom, couleur [r,g,b,a], glyphe (texte court, utilisé si l'application n'a pas d'icône dessinée),
            code d'ouverture (construit la page de l'application), permission ("" = tous, "admin" = rôles, ou permission précise), dansLeDock (true/false)] */
params ["_id", "_name", "_color", ["_glyph", ""], ["_open", {}], ["_perm", ""], ["_dock", false]];
if (isNil "PHN_apps") then { PHN_apps = []; };
PHN_apps = PHN_apps select { (_x select 0) != _id };
PHN_apps pushBack [_id, _name, _color, _glyph, _open, _perm, _dock];
