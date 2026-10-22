# Téléphone (module PHN)

## Utilisation
- Touche d'ouverture par défaut : **P** (code 25). Modifiable en jeu : Téléphone > Réglages > "Modifier la touche".
- Clic sur la barre blanche en bas du téléphone : retour à l'accueil (puis fermeture). Touche Échap : fermeture.
- Applications : Téléphone (appels), Chat (discussions, profil, statuts ; première connexion avec numéro, nom et avatar), Banque (compte, virements, carte, historique ; le dépôt et le retrait d'espèces sont réservés aux futurs distributeurs), Réglages, Admin (selon rôle).
- Les papiers (carte d'identité, permis) ne sont PAS dans le téléphone : ce sont des objets physiques de l'inventaire (double-clic pour les montrer).

## Rôles (administration)
Dans `config/settings.hpp`, classe `PHN_Roles`, ajoute le **SteamID64** du joueur (17 chiffres) dans `uids[]` :
    uids[] = {"76561198000000000"};
Pour trouver ton SteamID64 : en jeu, console de debug : `getPlayerUID player` (ou depuis ton profil Steam / steamid.io).
Permissions : money, item, arsenal, god, heal, tp. Le SERVEUR vérifie la permission à chaque action et journalise dans le .rpt (lignes `[PHN][ADMIN]`).
**En test** (`devMode = 1` et `devAllAdmin = 1`), tout le monde est admin : mets `devAllAdmin = 0` avant l'ouverture.

## Codes de touches (DIK) courants
P 25 | O 24 | L 38 | K 37 | J 36 | H 35 | U 22 | Y 21 | T 20 | Home 199 | End 207 | Insert 210 | Delete 211 | PageUp 201 | PageDown 209
F1..F10 = 59..68 | F11 87 | F12 88 | Pavé numérique 0..9 : 82, 79, 80, 81, 75, 76, 77, 71, 72, 73

## Appels vocaux (expérimental)
Les appels utilisent des canaux radio personnalisés (6 appels simultanés par défaut). Une fois l'appel connecté, le canal "Appel" est sélectionné :
on parle avec la touche de voix (VON) habituelle. Le serveur doit avoir `disableVoN = 0` (c'est le cas dans server.cfg.example).

## Créer une nouvelle application
Dans n'importe quel module (côté client, par exemple dans un postInit), enregistre l'application :

    ["taxi", "Taxi", [0.95,0.80,0.10,1], "T", MON_fnc_pgTaxi, "", false] call PHN_fnc_registerApp;
    //  id    nom     couleur             glyphe  page d'ouverture  permission  dansLeDock

- permission : "" = tout le monde, "admin" = tout joueur ayant un rôle, ou une permission précise ("money", "tp"...).
- glyphe : 1 à 3 lettres affichées dans l'icône (une icône dessinée existe seulement pour les applications de base).
- L'icône apparaît automatiquement sur l'écran d'accueil.

La page (fonction MON_fnc_pgTaxi) se construit avec les outils ci-dessous. Coordonnées en FRACTIONS (0 à 1) de la zone de contenu :

    ["Taxi", true] call PHN_fnc_uiHeader;                                   // titre + bouton retour
    [0.04, 0.1, 0.92, 0.05, "Où allez-vous ?", 0.03, [1,1,1,1], "left"] call PHN_fnc_uiText;
    [0.04, 0.16, 0.92, 0.06, "", 0.03, "dest"] call PHN_fnc_uiEdit;          // champ de saisie, retrouvable par PHN_refs get "dest"
    [0.04, 0.25, 0.92, 0.065, "Commander", [0.2,0.6,0.35,1], [1,1,1,1], {
        params ["_donnee"];
        private _dest = ctrlText (PHN_refs get "dest");
        [player, _dest] remoteExec ["MON_fnc_srvTaxi", 2];                   // ne jamais décider côté client : le serveur valide
    }, [], 12, 0.03] call PHN_fnc_uiButton;
    [0.04, 0.35, 0.92, 0.1, [0.15,0.15,0.2,1], 14] call PHN_fnc_uiRect;      // rectangle (rayon 14 pixels = coins arrondis)

Autres outils : `[code, args] call PHN_fnc_showPage` (changer de page), `[0.7] call PHN_fnc_refresh` (redessiner après un délai),
`[texte] call PHN_fnc_esc` (échapper un texte pour le structured text), `[fw] call PHN_fnc_squareH` (hauteur d'un carré pour une largeur donnée).
Règles : une page = une fonction ; l'état entre les clics va dans des variables globales préfixées (ex. MON_etat) ou dans PHN_refs ;
les `remoteExec` doivent être déclarés dans le remoteExec.hpp du module (liste blanche).

## Noms des applications
`chatAppName` et `bankAppName` dans `config/settings.hpp` (aucun nom de marque réelle n'est utilisé par défaut).

## Outils d'interface pour vos applications (en plus de ceux listés plus bas)
- `[couleur] call PHN_fnc_uiAppBg;` : fond plein écran (arrondi comme l'écran) + barre d'état. À appeler au début d'une page pour un fond coloré.
- `[libellés, onglet actif, code] call PHN_fnc_uiTabBar;` : barre d'onglets en bas (le code reçoit [index]).
- `[fx, fy, fw, indexCouleur, initiales] call PHN_fnc_uiAvatar;` : avatar rond.
- `[x, y, taille px, couleur, double] call PHN_fnc_uiTick;` : coche simple/double (en coordonnées absolues).

## Rendu réaliste (images)
Le téléphone utilise des images .paa placées dans `phoneSystem/img/` (cadre titane, fonds d'écran, icônes, dock, île dynamique).
Les sources PNG se trouvent dans `tools/phone_assets/` (script `make_phone_assets.py` pour les régénérer / changer les couleurs).
Elles doivent être converties en .paa (outil en ligne paa.gruppe-adler.de ou ImageToPAA d'Arma 3 Tools).
Sans ces fichiers, un dessin vectoriel de secours est utilisé (réglage `useImages` dans settings.hpp).
Pour une application personnalisée : l'icône utilise `iconbase_ca` teintée de la couleur de l'application + le glyphe texte.
Pour ajouter une icône à une application : déposer `glyph_<id>_ca.paa` (128x128, blanc sur transparent) dans `phoneSystem/img/`.

## Limites connues
- Les messages ne sont délivrés qu'aux joueurs connectés (pas de messagerie hors ligne tant que la base de données n'est pas branchée).
- Pas de contacts enregistrés pour l'instant.
