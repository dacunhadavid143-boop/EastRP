/* Hauteur (fraction de la zone de contenu) qui rend un carré en pixels pour une largeur donnée (fraction de la zone). params: [fw] */
params ["_fw"];
private _c = PHN_C;
((_fw * (_c select 2)) / pixelW * pixelH) / (_c select 3)
