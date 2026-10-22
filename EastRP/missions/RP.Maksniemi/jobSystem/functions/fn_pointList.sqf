/* Points de travail dont le nom commence par un préfixe : marqueurs de l'éditeur ET objets nommés dans l'éditeur
   (champ « Nom de la variable », ex : un bureau nommé job_usine_service_1). params: [préfixe] -> [noms] */
params ["_p"];
_p = toLower _p;
(allMapMarkers select { (toLower _x find _p) == 0 }) + (JOB_objs select { (_x find _p) == 0 })
