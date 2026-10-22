class NEED_Settings
{
    tickSeconds      = 30;     // fréquence de mise à jour de la faim et de la soif
    start            = 80;     // valeur de départ (nouveau joueur ou après une mort), sur 100
    hungerPerMinute  = 0.8;    // points de faim perdus par minute (100 -> 0 en ~2 h)
    thirstPerMinute  = 1.2;    // points de soif perdus par minute (100 -> 0 en ~1 h 20)
    debug            = 0;      // 1 = messages de diagnostic [NEED debug] dans le chat. METTRE 0 quand tout marche
    showInInventory  = 0;      // 1 = barres aussi dessinées dans l'écran d'inventaire (inutile si le HUD permanent est actif)
    invCorner        = "bottomleft"; // topleft | topright | bottomleft | bottomright (l'argent est par défaut en bas à droite)
    showOnScreen     = 1;      // 1 = barres santé/faim/soif visibles EN PERMANENCE à l'écran
    hudCorner        = "bottomleft"; // coin du HUD permanent : topleft | topright | bottomleft | bottomright
    starvationDamage = 0.03;   // dégâts (0 à 1) infligés à chaque mise à jour quand faim ou soif = 0
};

// Objets consommables (double-clic dans l'inventaire). Ce sont les objets de notre addon eastrp_core (modpack @EastRP).
// thirst / hunger = points rendus (sur 100).
class NEED_CfgConsumables
{
    class EastRP_Water    { displayName = "Bouteille d'eau"; thirst = 40; hunger = 0;  };
    class EastRP_Sandwich { displayName = "Sandwich";        thirst = 0;  hunger = 35; };
    class EastRP_Ration   { displayName = "Ration";          thirst = 5;  hunger = 50; };
};
