/* SPN_fnc_camFocus : recentre la caméra sur un point. params: [point] */
params ["_p"];
SPN_camCenter = +(_p select 3);
SPN_camDist   = (_p select 5) max 4;
SPN_camHeight = (_p select 6) max 2;
cutText ["", "BLACK IN", 0.4];
