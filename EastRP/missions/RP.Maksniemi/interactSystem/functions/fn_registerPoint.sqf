/* ENREGISTRER UN TYPE DE POINT D'INTÉRÊT (distributeur, boutique, usine...).
   Les positions viennent de marqueurs de l'éditeur dont le nom commence par le préfixe (ex: "int_atm" : int_atm_1, int_atm_2...).
   params: [type, libellé affiché, préfixe de marqueur, rayon d'action en mètres] */
params ["_type", "_label", "_prefix", ["_radius", 3]];
if (isNil "INT_points") then { INT_points = createHashMap; };
INT_points set [_type, [_label, _prefix, _radius]];
