class CORE_Settings
{
    currencyName    = "Couronne";   // nom de la monnaie (à changer)
    currencySymbol  = "Kr";         // symbole affiché
    startCash       = 500;          // espèces d'un nouveau joueur
    startBank       = 2000;         // solde bancaire d'un nouveau joueur
    autosaveSeconds = 300;          // sauvegarde automatique
    restoreOnLogin  = 1;            // 1 = à la reconnexion, le joueur retrouve son équipement et sa position
    invMoneyCorner  = "topright";   // utilisé seulement si la barre de titre de l'inventaire n'est pas trouvée : topright, topleft, bottomright, bottomleft
    invMoneyMargin[] = {0.01, 0.01}; // marge depuis les bords (X, Y)
    dbName          = "eastrp";     // nom de la section dans extdb3-conf.ini
    dbTest          = 0;            // 1 = au démarrage, teste la connexion à la base (résultat dans le .rpt, lignes [CORE][DB])
    storage         = "profile";    // "profile" = test (profil du serveur). "extdb3" = base de données (à venir)
    debug           = 0;            // 1 = messages de diagnostic [CORE debug] dans le chat. METTRE 0 quand tout marche
    devMode         = 0;            // 1 = actions de test [DEV]. METTRE 0 EN PRODUCTION
};
