class ECO_Settings
{
    debug              = 0;       // 1 = messages [ECO debug] dans le chat et le .rpt (METTRE 0 quand tout marche)
    // Objets reconnus comme distributeurs : ceux de l'addon @EastRP, et les distributeurs du jeu de base (utiles pour tester sans l'addon)
    atmClasses[]       = {"EastRP_ATM", "EastRP_ATM_Abri", "Land_Billet", "Land_Atm_01_F", "Land_Atm_02_F"};   // Land_Billet = ATM du mod d'Enrico
    atmMaxPerOperation = 10000;   // montant maximum par dépôt ou retrait
    atmDistance        = 6;       // distance maximale (mètres, mesurée jusqu'à la SURFACE de l'objet) pour utiliser un distributeur
    shopDistance       = 7;       // idem pour une boutique
    // Caisses / bornes : objets à viser pour acheter. Une caisse prend le type du bâtiment-boutique le plus proche (ECO_ShopClasses),
    // ou "general" s'il n'y en a pas. Correspondance sur le DÉBUT du nom de classe.
    counterClasses[]   = {"Land_CashDesk_F"};
    counterRadius      = 30;      // rayon (m) de recherche du bâtiment-boutique autour d'une caisse
    buildingShops      = 0;       // 0 = on achète uniquement à une caisse ; 1 = viser le bâtiment entier suffit aussi
};

// Bâtiments reconnus comme boutiques (mod d'Enrico) : nom de classe (ou début du nom de classe) = type de catalogue.
// Exemple : "Land_Intermarche" couvre aussi Land_Intermarche_sans_... (correspondance sur le début du nom).
class ECO_ShopClasses
{
    Land_Shop_Station = "station";
    Land_Intermarche  = "supermarche";
    Land_Castorama    = "bricolage";
};

// Catalogues des boutiques. Le type d'une boutique vient de l'objet (addon : propriété eastrp_shop) ou de sa variable "eastrp_shop".
// item = nom technique de l'objet donné au joueur (objets EastRP_... : notre addon eastrp_core, dans le modpack). Ne vends PAS ItemWatch ni ItemCompass (utilisés pour la carte d'identité et le permis).
class ECO_Shops
{
    class epicerie
    {
        displayName = "Epicerie";
        class Items
        {
            class water  { displayName = "Bouteille d'eau"; item = "EastRP_Water";     price = 15; };
            class ration { displayName = "Ration";          item = "EastRP_Ration";    price = 25; };
        };
    };
    class station
    {
        displayName = "Station-service";
        class Items
        {
            class water  { displayName = "Bouteille d'eau"; item = "EastRP_Water";     price = 18; };
            class sandwich { displayName = "Sandwich";      item = "EastRP_Sandwich";  price = 30; };
            class map    { displayName = "Carte de la region"; item = "ItemMap";       price = 12; };
        };
    };
    class supermarche
    {
        displayName = "Supermarche";
        class Items
        {
            class water  { displayName = "Bouteille d'eau"; item = "EastRP_Water";     price = 12; };
            class ration { displayName = "Ration";          item = "EastRP_Ration";    price = 22; };
        };
    };
    class bricolage
    {
        displayName = "Bricolage";
        class Items
        {
            class toolkit { displayName = "Trousse a outils"; item = "ToolKit";   price = 80;  };
            class binocs  { displayName = "Jumelles";         item = "Binocular"; price = 120; };
        };
    };
    class restauration
    {
        displayName = "Restauration";
        class Items
        {
            class water  { displayName = "Bouteille d'eau"; item = "EastRP_Water";     price = 12; };
            class sandwich { displayName = "Sandwich";      item = "EastRP_Sandwich";  price = 25; };
        };
    };
    class presse
    {
        displayName = "Presse";
        class Items
        {
            class map { displayName = "Carte de la region"; item = "ItemMap"; price = 10; };
        };
    };
    class general
    {
        displayName = "Magasin";
        class Items
        {
            class water  { displayName = "Bouteille d'eau"; item = "EastRP_Water";     price = 15; };
            class ration { displayName = "Ration";          item = "EastRP_Ration";    price = 25; };
            class map    { displayName = "Carte de la region"; item = "ItemMap";       price = 10; };
        };
    };
};
