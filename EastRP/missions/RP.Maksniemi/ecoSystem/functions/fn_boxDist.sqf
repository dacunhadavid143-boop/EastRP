/* Distance (mètres) entre un joueur et la SURFACE (boîte englobante) d'un objet : fiable aussi pour un grand bâtiment,
   contrairement à "distance" qui mesure jusqu'au centre. params: [objet, joueur] */
params ["_o", "_u"];
if (isNull _o || {isNull _u}) exitWith { 1e6 };
private _bb = boundingBoxReal _o;
private _mn = _bb select 0;
private _mx = _bb select 1;
private _p = _o worldToModel (position _u);
private _c = [
    ((_p select 0) max (_mn select 0)) min (_mx select 0),
    ((_p select 1) max (_mn select 1)) min (_mx select 1),
    ((_p select 2) max (_mn select 2)) min (_mx select 2)
];
_p distance _c
