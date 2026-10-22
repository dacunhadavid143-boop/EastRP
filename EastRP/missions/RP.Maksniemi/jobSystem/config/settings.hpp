class JOB_Settings
{
    minContractMinutes  = 2;     // TEST ! remettre 240 (= 4 h) avant l ouverture. Contrat minimum : minutes de TRAVAIL EN SERVICE avant de pouvoir démissionner (240 = 4 h). Mettre 2 pour tester
    quitCooldownMinutes = 1;     // TEST ! (valeur conseillée en production : 15). Après une démission, délai (minutes réelles) avant de pouvoir signer un nouveau contrat
    afkMinutes          = 10;    // le temps de contrat ne compte que si le joueur a terminé une tâche dans les X dernières minutes (anti-AFK)
    pointRadius         = 4;     // distance (m) à laquelle on peut utiliser un point de travail (marqueur)
    poleClasses[]       = {};    // bâtiments entiers reconnus comme Pôle Emploi (vide = seulement le bureau/objet nommé job_pole_1, job_pole_2...). Ex : {"Land_Pole_Emploi"}
    poleDistance        = 30;    // distance max (m) au Pôle Emploi pour signer ou démissionner
    arrowClass          = "Sign_Arrow_Large_Yellow_F";   // flèche 3D affichée au-dessus du point de la tâche en cours
    gpsSize             = 300;   // taille (pixels) de la fenêtre GPS
    gpsZoom             = 0.09;  // zoom du GPS (plus petit = plus proche)
    gpsWidth            = 3;     // demi-largeur (m) du trait de l'itinéraire
    vehRadius           = 10;    // distance (m) au point pour les étapes à faire EN VÉHICULE (tracteur, camion...)
    vehFallback         = "C_Offroad_01_F";   // véhicule utilisé si la classe d'un niveau n'existe pas dans les mods chargés
    quizPenalty         = 0.5;
    pumpStockMax        = 50;    // nombre maximum de pompes en attente de contrôle dans la caisse de l'usine   // salaire de la tâche multiplié par ce nombre en cas de mauvais diagnostic / mauvais contrôle
    debug               = 0;     // 1 = messages [JOB debug] dans le chat et le .rpt
};

// MÉTIERS. Chaque niveau a ses propres étapes (une boucle d'étapes = une tâche payée).
// Étape : {"préfixe des points", "texte de l'action", durée (s), mode, "animation", objets en main, "spécial"}
//   mode    : "any" (n'importe quel point) | "random" (le serveur en impose un au hasard) | "same" (le même point qu'à l'étape d'avant)
//   animation (facultatif, addon eastrp_core) et objets en main (facultatif) : voir ELEC_PROPS
//   spécial (facultatif) : "vehget" = sortir le véhicule de service du niveau (étape sautée si on l'a déjà)
//                          "veh"    = étape à faire AU VOLANT du véhicule de service (déclenchée automatiquement en arrivant au point)
//                          "quiz:usine" / "quiz:elec" = mini-jeu de diagnostic après l'action (questions dans JOB_Quiz, plus bas)
//                          "quiz:fiche" = fiche de contrôle d'une pompe (schéma + mesures tirées au hasard, conforme ou non)
//                          "qcDrop" = déposer la pompe contrôlée : caisse d'expédition (job_usine_expedition_*) si validée, benne à rebut (job_usine_rebut_*) si refusée
//                          "pumpIn" = range une pompe dans la caisse de l'usine ; "pumpOut" = en prend une (pompe de réserve si la caisse est vide)
//   objet requis / objet donné (facultatifs) : objets d'inventaire de l'addon eastrp_core (EastRP_PieceBrute...), vérifiés et échangés par le serveur
// Niveau : vehicle = classe du véhicule de service ; vehicleSpawn = préfixe des marqueurs de stationnement (job_elec_parking_1...) ;
//          gps = 1/0 (remplace le réglage du métier) ; teamBonus = +X % de salaire par collègue du même métier en service à moins de 150 m (max 3)
// Les points se placent dans l'éditeur : objets nommés (champ « Nom de la variable ») ou marqueurs « Vide / Empty » : job_usine_stock_1, job_usine_stock_2...
// Objets tenus en main pendant la relève : {classe, os de la main, décalage [x,y,z], apparition (s), disparition (s)}
#define ELEC_PROPS {{"Land_Notepad_F", "lefthand", {0, 0, 0}, 4.7, 13.3}, {"Land_PenBlack_F", "righthand", {0, 0, 0}, 4.7, 13.3}}
class JOB_Jobs
{
    class usine
    {
        displayName = "Ouvrier - usine de pompes à eau";
        short       = "Usine";
        gps         = 0;
        description = "Fabrication de pompes à eau : manutention, montage, contrôle qualité.";
        class Levels
        {
            class L1 { title = "Manutentionnaire";   xpRequired = 0;   xpPerTask = 10; pay = 45;
                steps[] = { {"job_usine_stock", "Prendre des pièces au stock", 4, "any"}, {"job_usine_chaine", "Déposer les pièces à la chaîne", 3, "any"} }; };
            class L2 { title = "Opérateur CNC";      xpRequired = 20; /*TEST! prod 300*/ xpPerTask = 12; pay = 75;
                steps[] = { {"job_usine_stock",  "Prendre une pièce brute au stock",              4, "any",  "", {}, "",       "",                   "EastRP_PieceBrute"},
                            {"job_usine_cnc",    "Charger la pièce et lancer l'usinage",         10, "any",  "", {}, "",       "EastRP_PieceBrute",  ""},
                            {"job_usine_cnc",    "Décharger la pièce usinée",                     4, "same", "", {}, "",       "",                   "EastRP_PieceUsinee"},
                            {"job_usine_ligne",  "Ébavurer et laver la pièce sur la ligne",       8, "any",  "", {}, "",       "EastRP_PieceUsinee", "EastRP_CorpsPompe"},
                            {"job_usine_chaine", "Monter la pompe et la ranger dans la caisse",   6, "any",  "", {}, "pumpIn", "EastRP_CorpsPompe",  ""} }; };
            class L3 { title = "Contrôleur qualité"; xpRequired = 40; /*TEST! prod 900*/ xpPerTask = 15; pay = 105;
                steps[] = { {"job_usine_caisse",  "Prendre une pompe à contrôler",               3, "any",  "", {}, "pumpOut",    "",                "EastRP_PompeEau"},
                            {"job_usine_qualite", "Contrôler la pompe avec la fiche",           10, "any",  "", {}, "quiz:fiche", "EastRP_PompeEau", ""},
                            {"job_usine_expedition", "Déposer la pompe",                         3, "any",  "", {}, "qcDrop",     "EastRP_PompeEau", ""} }; };
        };
    };
    class elec
    {
        displayName = "Électricien";
        short       = "Électricité";
        gps         = 1;     // 1 = GPS à l'écran (itinéraire par la route) jusqu'au point de la tâche
        description = "Réseau électrique : compteurs, dépannages, transformateurs.";
        class Levels
        {
            class L1 { title = "Apprenti électricien"; xpRequired = 0;   xpPerTask = 10; pay = 50;
                steps[] = { {"job_elec_compteur", "Relever le compteur", 17, "random", "EastRP_ReleveCompteur", ELEC_PROPS} }; };
            class L2 { title = "Dépanneur";            xpRequired = 20; /*TEST! prod 300*/ xpPerTask = 12; pay = 80;
                vehicle = "C_Van_01_box_F"; vehicleSpawn = "job_elec_parking";
                steps[] = { {"job_elec_depot", "Prendre la camionnette de service", 3, "any", "", {}, "vehget"},
                            {"job_elec_panne", "Diagnostiquer la panne",           8, "random", "", {}, "quiz:elec"},
                            {"job_elec_panne", "Réparer la panne",                12, "same"} }; };
            class L3 { title = "Chef de chantier";     xpRequired = 40; /*TEST! prod 900*/ xpPerTask = 15; pay = 110; teamBonus = 0.2;
                vehicle = "C_Van_01_box_F"; vehicleSpawn = "job_elec_parking";
                steps[] = { {"job_elec_depot",  "Prendre la camionnette de service", 3, "any", "", {}, "vehget"},
                            {"job_elec_poteau", "Couper la ligne au poteau",         6, "random"},
                            {"job_elec_transfo","Sécuriser le transformateur",       8, "random"},
                            {"job_elec_transfo","Réparer le transformateur",        15, "same"} }; };
        };
    };
    class ferme
    {
        displayName = "Ouvrier agricole";
        short       = "Ferme";
        gps         = 0;
        description = "Travail à la ferme : récolte, tracteur, vente à la coopérative.";
        class Levels
        {
            class L1 { title = "Ouvrier agricole"; xpRequired = 0;   xpPerTask = 10; pay = 45;
                steps[] = { {"job_ferme_champ", "Récolter", 6, "random"}, {"job_ferme_hangar", "Déposer la récolte au hangar", 3, "any"} }; };
            class L2 { title = "Tractoriste";      xpRequired = 20; /*TEST! prod 300*/ xpPerTask = 12; pay = 75;
                vehicle = "C_Tractor_01_F"; vehicleSpawn = "job_ferme_parking";
                steps[] = { {"job_ferme_garage", "Prendre le tracteur",                 3, "any",    "", {}, "vehget"},
                            {"job_ferme_labour", "Labourer (passer avec le tracteur)",  3, "random", "", {}, "veh"},
                            {"job_ferme_labour", "Labourer (passer avec le tracteur)",  3, "random", "", {}, "veh"},
                            {"job_ferme_labour", "Labourer (passer avec le tracteur)",  3, "random", "", {}, "veh"},
                            {"job_ferme_labour", "Labourer (passer avec le tracteur)",  3, "random", "", {}, "veh"},
                            {"job_ferme_hangar", "Ramener le tracteur au hangar",       4, "any",    "", {}, "veh"} }; };
            class L3 { title = "Gérant de ferme";  xpRequired = 40; /*TEST! prod 900*/ xpPerTask = 15; pay = 140; gps = 1;
                vehicle = "C_Truck_02_transport_F"; vehicleSpawn = "job_ferme_parking";
                steps[] = { {"job_ferme_garage", "Prendre le camion",                   3, "any", "", {}, "vehget"},
                            {"job_ferme_hangar", "Charger la récolte dans le camion",  10, "any", "", {}, "veh"},
                            {"job_ferme_coop",   "Livrer la récolte à la coopérative", 10, "any", "", {}, "veh"} }; };
        };
    };
};

// MINI-JEUX DE DIAGNOSTIC : {"situation", {"réponse 1", "réponse 2"...}, numéro de la bonne réponse (0 = la première)}
// Les réponses sont mélangées à l'affichage. On peut en ajouter autant qu'on veut.
class JOB_Quiz
{
    class usine
    {
        questions[] = {
            {"La pompe tourne sans bruit, aucune trace d'humidité, le joint est bien en place.", {"Conforme", "Défectueuse"}, 0},
            {"Une goutte d'eau perle sous le corps de pompe après 30 secondes de test.", {"Conforme", "Défectueuse"}, 1},
            {"Le moteur fait un cliquetis métallique au démarrage.", {"Conforme", "Défectueuse"}, 1},
            {"Les vis du capot sont toutes serrées et la pression reste stable à 3 bars.", {"Conforme", "Défectueuse"}, 0},
            {"Le joint torique est pincé et légèrement déformé.", {"Conforme", "Défectueuse"}, 1},
            {"La plaque d'identification est présente et le débit mesuré correspond à la fiche technique.", {"Conforme", "Défectueuse"}, 0},
            {"Le moteur chauffe anormalement après une minute de fonctionnement.", {"Conforme", "Défectueuse"}, 1},
            {"La peinture est uniforme et le raccord d'entrée est parfaitement vissé.", {"Conforme", "Défectueuse"}, 0}
        };
    };
    class elec
    {
        questions[] = {
            {"Le client n'a plus de courant dans toute la maison. Le disjoncteur général est en position basse.",
                {"Réarmer le disjoncteur général", "Changer le compteur", "Remplacer une ampoule"}, 0},
            {"Une seule pièce est privée de courant, les autres fonctionnent normalement.",
                {"Le disjoncteur de ce circuit a sauté", "Le transformateur du quartier est en panne", "Le compteur est cassé"}, 0},
            {"Tout le quartier est dans le noir, les voisins aussi.",
                {"Panne sur le réseau (transformateur)", "Une prise défectueuse chez le client", "Le fusible du four"}, 0},
            {"Le disjoncteur différentiel saute dès qu'on branche la machine à laver.",
                {"Fuite de courant sur la machine à laver", "Le compteur a été mal relevé", "Le câble du quartier est coupé"}, 0},
            {"Les lumières clignotent dans toute la maison quand le chauffage démarre.",
                {"Connexion desserrée au tableau électrique", "Les ampoules sont de mauvaise qualité", "Panne du réseau téléphonique"}, 0},
            {"Le compteur n'affiche plus rien, mais les voisins ont du courant.",
                {"Problème sur le branchement avant le compteur", "Une ampoule grillée", "Le chauffe-eau est trop chaud"}, 0}
        };
    };
};
