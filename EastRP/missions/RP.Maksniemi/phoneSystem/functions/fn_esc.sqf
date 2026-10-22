/* Échappe un texte pour l'affichage en "structured text" (empêche l'injection de balises). params: [texte] */
params [["_t", ""]];
private _out = "";
{
    _out = _out + (switch (_x) do {
        case 60: { "&lt;" };
        case 62: { "&gt;" };
        case 38: { "&amp;" };
        default  { toString [_x] };
    });
} forEach (toArray _t);
_out
