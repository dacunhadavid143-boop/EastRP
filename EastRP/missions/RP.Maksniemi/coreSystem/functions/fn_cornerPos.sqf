/* Position [x,y,w,h] d'un bloc de taille w*h dans un coin de l'écran. params: [coin, w, h, [margeX, margeY] (optionnel)] */
params ["_corner", "_w", "_h", ["_margin", [0.02, 0.02]]];
_margin params ["_mx", "_my"];
private _x = safeZoneX + _mx;
private _y = safeZoneY + _my;
if (_corner in ["topright", "bottomright"]) then { _x = safeZoneX + safeZoneW - _w - _mx; };
if (_corner in ["bottomleft", "bottomright"]) then { _y = safeZoneY + safeZoneH - _h - _my; };
[_x, _y, _w, _h]
