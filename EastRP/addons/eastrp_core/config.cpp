// EastRP - objets du serveur (bouteille d'eau, sandwich, ration...)
// Les objets sont des "chargeurs" (CfgMagazines) : ils s'empilent, se rangent dans l'uniforme/sac, et NE PEUVENT PAS être lancés.
class CfgPatches
{
    class EastRP_Core
    {
        name = "EastRP - Objets et animations";
        author = "EastRP";
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.0;
        requiredAddons[] = {"A3_Weapons_F", "A3_Anims_F_Config_Sdr"};
    };
};

class CfgMagazines
{
    class CA_Magazine;
    class EastRP_ItemBase: CA_Magazine
    {
        scope = 1;
        author = "EastRP";
        count = 1;
        mass = 4;
        type = 256;
        ammo = "";
        initSpeed = 0;
        model = "\A3\Weapons_F\Ammo\mag_univ.p3d";
        displayNameShort = "";
        descriptionShort = "";
    };

    // --- Nourriture et boissons (effets définis dans la mission : needSystem\config\settings.hpp) ---
    class EastRP_Water: EastRP_ItemBase
    {
        scope = 2;
        displayName = "Bouteille d'eau";
        descriptionShort = "Double-clic pour boire.";
        picture = "\eastrp_core\data\water_ca.paa";
        model = "\A3\Structures_F_EPA\Items\Food\BottlePlastic_V2_F.p3d";
        mass = 5;
    };
    class EastRP_Sandwich: EastRP_ItemBase
    {
        scope = 2;
        displayName = "Sandwich";
        descriptionShort = "Double-clic pour manger.";
        picture = "\eastrp_core\data\sandwich_ca.paa";
        model = "\A3\Structures_F_EPA\Items\Food\TacticalBacon_F.p3d";
        mass = 3;
    };
    class EastRP_Ration: EastRP_ItemBase
    {
        scope = 2;
        displayName = "Ration";
        descriptionShort = "Double-clic pour manger.";
        picture = "\eastrp_core\data\ration_ca.paa";
        model = "\A3\Structures_F_EPA\Items\Food\BakedBeans_F.p3d";
        mass = 6;
    };

    // --- Usine de pompes à eau (métier) : donnés et repris par le serveur à chaque étape ---
    class EastRP_PieceBrute: EastRP_ItemBase
    {
        scope = 2;
        displayName = "Pièce métallique brute";
        descriptionShort = "Lopin d'acier à usiner sur la machine CNC.";
        picture = "\eastrp_core\data\piece_brute_ca.paa";
        mass = 10;
    };
    class EastRP_PieceUsinee: EastRP_ItemBase
    {
        scope = 2;
        displayName = "Pièce usinée";
        descriptionShort = "Bride sortie de la machine CNC, à ébavurer et laver.";
        picture = "\eastrp_core\data\piece_usinee_ca.paa";
        mass = 8;
    };
    class EastRP_CorpsPompe: EastRP_ItemBase
    {
        scope = 2;
        displayName = "Corps de pompe";
        descriptionShort = "Corps de pompe fini, à monter sur la chaîne.";
        picture = "\eastrp_core\data\corps_pompe_ca.paa";
        mass = 15;
    };
    class EastRP_PompeEau: EastRP_ItemBase
    {
        scope = 2;
        displayName = "Pompe à eau EP-40";
        descriptionShort = "Pompe à eau à contrôler au bureau qualité.";
        picture = "\eastrp_core\data\pompe_eau_ca.paa";
        mass = 40;
    };
};

// --- Animations (fichiers .rtm dans anim\) ---
// Jouées par la mission avec switchMove (JOB_fnc_clientAnim). Ensuite retour à genoux puis debout (animations du jeu).
class CfgMovesBasic;
class CfgMovesMaleSdr: CfgMovesBasic
{
    class States
    {
        class CutSceneAnimationBase;
        class EastRP_ReleveCompteur: CutSceneAnimationBase
        {
            file = "\eastrp_core\anim\eastrp_releve_compteur_v2.rtm";   // électricien : à genoux, ouvre le boîtier, note sur un carnet, se relève (vidéo -> DeepMotion -> Blender)
            speed = 0.0607;        // 1 / durée en secondes (494 images à 30 i/s = 16,5 s)
            looped = 0;
            disableWeapons = 1;
            disableWeaponsLong = 1;
            canPullTrigger = 0;
            actions = "NoActions";      // sans ça, le "pilote" du joueur le remet debout aussitôt (CivilStandActions hérité)
            minPlayTime = 1;           // ne peut pas être interrompue avant la fin (sauf par le script, ou inconscience)
            ConnectTo[] = {"AmovPknlMstpSnonWnonDnon", 0.1};
            InterpolateTo[] = {"AmovPknlMstpSnonWnonDnon", 0.2, "AmovPercMstpSnonWnonDnon", 0.2, "Unconscious", 0.1};
        };
    };
};
