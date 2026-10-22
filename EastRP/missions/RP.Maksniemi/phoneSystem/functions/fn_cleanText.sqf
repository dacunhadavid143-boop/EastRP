/* Nettoie un texte saisi : caractères de contrôle et < > retirés, longueur limitée. params: [texte, longueurMax] */
params [["_t", ""], ["_max", 100]];
_t = toString ((toArray _t) select { _x >= 32 && {_x != 127} && {_x != 60} && {_x != 62} });
if (count _t > _max) then { _t = _t select [0, _max]; };
_t
