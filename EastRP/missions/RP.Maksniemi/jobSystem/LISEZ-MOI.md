# Métiers (module JOB)

## Fonctionnement
- **Pôle Emploi** : TAB devant le bâtiment (Land_Pole_Emploi) ou un marqueur `job_pole_1`. On y signe un contrat (un seul métier à la fois) et on y démissionne.
- **Contrat minimum** : `minContractMinutes` (240 = 4 h) de travail EN SERVICE avant de pouvoir démissionner. Le temps ne compte que si une tâche a été terminée dans les `afkMinutes` dernières minutes.
- **Carence** : après une démission, `quitCooldownMinutes` (temps réel) avant de pouvoir signer un nouveau contrat.
- **Expérience par métier** : un nouveau métier commence à 0 XP ; en revenant dans un ancien métier, on retrouve son niveau.
- **Service** : TAB sur le lieu de travail (`job_<métier>_service_1`) : « Prendre mon service » / « Terminer mon service ».
- **Tâches** : un repère orange (carte + écran) indique où aller. TAB sur le point, rester sur place pendant la durée. Fin de tâche = salaire sur le compte bancaire + XP.
- **Téléphone** : application « Emploi » (métier, niveau, XP, tâche, contrat).

## Points de travail : des OBJETS (recommandé) ou des marqueurs
Pose un objet (bureau, borne, pointeuse, caisses, compteur...) et donne-lui un nom dans l'éditeur :
double-clic sur l'objet -> champ « Nom de la variable » (en minuscules, sans espace ni accent). On interagit en le visant (TAB).
Un marqueur « Vide / Empty » portant le même nom fonctionne aussi (pratique pour une zone sans objet, ex : un champ).

| Nom | Rôle | Idée d'objet |
|---|---|---|
| job_pole_1 | Accueil du Pôle Emploi (facultatif si le bâtiment Land_Pole_Emploi est posé) | bureau d'accueil |
| job_usine_service_1 | Usine : prise de service | pointeuse / borne |
| job_usine_stock_1, _2... | Usine : stock de pièces | caisses, palettes |
| job_usine_chaine_1, _2... | Usine : chaîne de montage | établi |
| job_elec_service_1 | Électricien : prise de service | bureau / borne du dépôt |
| job_elec_compteur_1 ... _10 | Électricien : compteurs à relever (au hasard) | boîtier électrique |
| job_ferme_service_1 | Ferme : prise de service | bureau de la ferme |
| job_ferme_champ_1 ... _6 | Ferme : zones de récolte (au hasard) | marqueur dans le champ |
| job_ferme_hangar_1 | Ferme : dépôt de la récolte | caisses, palettes |

## Points des niveaux 2 et 3 (à placer dans l'éditeur)
| Nom | Niveau | Rôle | Idée d'objet |
|---|---|---|---|
| job_usine_cnc_1, _2... | Usine N2 | Machine CNC (charger / décharger la pièce) | machine-outil |
| job_usine_ligne_1 | Usine N2 | Chaîne de traitement (ébavurage, lavage) | convoyeur, bac de lavage |
| job_usine_caisse_1 | Usine N3 | Caisse des pompes à contrôler (inventaire verrouillé) | caisse |
| job_usine_qualite_1 | Usine N3 | Bureau qualité : fiche de contrôle | bureau |
| job_usine_expedition_1 | Usine N3 | Caisse des pompes validées (expédition) | caisse, palette |
| job_usine_rebut_1 | Usine N3 | Benne des pompes refusées (rebut) | benne à ordures |
| job_elec_depot_1 | Élec N2-3 | Dépôt : sortir la camionnette | borne / bureau du dépôt |
| job_elec_parking_1, _2... | Élec N2-3 | Places où apparaît la camionnette | MARQUEUR « Vide », flèche dans le sens de la place |
| job_elec_panne_1 ... _10 | Élec N2 | Clients en panne (au hasard) | boîtier électrique, coffret mural |
| job_elec_poteau_1 ... _6 | Élec N3 | Poteaux où couper la ligne | poteau électrique |
| job_elec_transfo_1 ... _6 | Élec N3 | Transformateurs à réparer | transformateur |
| job_ferme_garage_1 | Ferme N2-3 | Garage : sortir le tracteur / le camion | bureau, borne, établi |
| job_ferme_parking_1, _2... | Ferme N2-3 | Places où apparaît le véhicule | MARQUEUR « Vide » |
| job_ferme_labour_1 ... _8 | Ferme N2 | Points de labour, à passer avec le tracteur | MARQUEUR dans le champ |
| job_ferme_coop_1 | Ferme N3 | Coopérative (livraison en camion) | hangar / quai de la coopérative |

Les étapes « au volant » (labour, hangar et coopérative en N2-3) se déclenchent toutes seules en arrivant à moins de `vehRadius` mètres du point avec le véhicule de service.
Le véhicule de service est réservé au joueur, rangé en fin de service, à la démission, à la promotion et à la déconnexion.

## Réglages
`config/settings.hpp` : durées, salaires (`pay`), XP par tâche (`xpPerTask`), XP requise par niveau (`xpRequired`), étapes de chaque niveau.
Véhicules de service : `vehicle` dans chaque niveau (si la classe n'existe pas, `vehFallback` est utilisé). Mini-jeux : classe `JOB_Quiz` (on peut ajouter des questions).

## Objets de l'usine (addon eastrp_core)
Pièce brute (stock) -> CNC -> Pièce usinée -> ligne -> Corps de pompe -> chaîne : la pompe est rangée dans la caisse (compteur sur le serveur).
Le contrôleur (N3) prend une pompe dans la caisse (pompe de réserve si elle est vide), contrôle la fiche au bureau qualité et valide ou refuse.
Seule l'étape en cours propose l'action : un niveau 2 ne peut pas prendre de pompe dans la caisse.
