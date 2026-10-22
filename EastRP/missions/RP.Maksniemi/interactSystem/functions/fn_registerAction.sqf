/* ENREGISTRER UNE INTERACTION (appelable par n'importe quel module, côté client).
   params: [id, libellé, type de cible, condition, action, ordre (optionnel, plus petit = plus haut dans le menu)]
   Le libellé est un texte, ou un code { params ["_cible"]; "texte" } calculé selon la cible (ex : le nom de la boutique).
   Types de cible : "player" (joueur proche), "vehicle" (véhicule visé), "object" (objet visé), "point:<type>" (marqueur d'un point d'intérêt enregistré)
   La condition et l'action reçoivent [cible] (joueur, véhicule, objet ou nom de marqueur). */
params ["_id", "_label", "_kind", ["_cond", { true }], ["_use", {}], ["_order", 50]];
if (isNil "INT_actions") then { INT_actions = []; };
INT_actions = INT_actions select { (_x select 0) != _id };
INT_actions pushBack [_id, _label, _kind, _cond, _use, _order];
