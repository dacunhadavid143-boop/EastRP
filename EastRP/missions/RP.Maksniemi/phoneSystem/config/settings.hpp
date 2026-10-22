class PHN_Settings
{
    defaultKey    = 25;    // touche d'ouverture par défaut (code DIK). 25 = P. Modifiable en jeu dans Réglages. Liste des codes dans phoneSystem\LISEZ-MOI.md
    uiScale       = 0.86;  // hauteur du téléphone, en fraction de la hauteur de l'écran
    callRingSeconds = 30;  // durée de sonnerie avant "pas de réponse"
    callChannels  = 6;     // nombre d'appels simultanés maximum
    useImages     = 1;     // 1 = utilise les images .paa du dossier img/ si elles existent (rendu réaliste), sinon dessin vectoriel de secours
    chatAppName   = "Chat";      // nom affiché de l'application de discussion (à changer librement)
    bankAppName   = "Banque";    // nom affiché de l'application bancaire
    devAllAdmin   = 0;     // 1 + devMode = TOUS les joueurs ont tous les droits admin (TEST uniquement). METTRE 0 EN PRODUCTION
};

// Rôles : mets ici les SteamID64 (17 chiffres) des joueurs. Les permissions sont vérifiées par le SERVEUR.
// Permissions : money, item, arsenal, god, heal, tp
class PHN_Roles
{
    class admin
    {
        displayName = "Administrateur";
        uids[]  = {"76561198000000000"};
        perms[] = {"money","item","arsenal","god","heal","tp"};
    };
    class moderator
    {
        displayName = "Modérateur";
        uids[]  = {};
        perms[] = {"heal","tp"};
    };
};
