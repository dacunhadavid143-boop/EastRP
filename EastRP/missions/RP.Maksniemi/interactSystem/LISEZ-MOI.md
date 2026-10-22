# Système d'interaction (module INT)

## Utilisation
- Touche par défaut : **TAB** (code 15). Modifiable dans `config/settings.hpp` (`defaultKey`). Codes courants : E 18, F 33, G 34, X 45, Y 21, H 35.
- Quand quelque chose est utilisable à proximité, l'indication « [TAB] Interagir - cible » s'affiche en bas de l'écran.
  La touche ouvre alors un menu : on clique à la souris sur l'option voulue (ex : « Distributeur »). La même touche (ou Échap) ferme le menu.
- S'il n'y a rien à faire, la touche n'est PAS bloquée : elle garde son rôle normal dans le jeu.

## Ce qui est déjà branché
- Joueur proche (visé, ou à moins de 2,5 m) : « Montrer ma carte d'identité », « Montrer mon permis de conduire » (l'autre joueur voit ta carte, avec ta photo).
- Test (devMode) : place un marqueur nommé `int_test_1` dans l'éditeur, approche-toi à 3 m ; ou vise un objet à moins de 3 m (« Inspecter »).

## Créer une interaction (n'importe quel module, côté client)
    ["monid", "Libellé affiché", "player", { true }, { params ["_cible"]; /* ton code */ }, 50] call INT_fnc_registerAction;
    //  id       libellé           cible     condition   action (reçoit [cible])                    ordre (petit = en haut)
    //  Le libellé peut être un code : { params ["_cible"]; "Nom calculé" } (ex : le nom de la boutique visée).
Types de cible : "player" (autre joueur), "npc" (personnage non joueur), "vehicle", "object", "point:<type>".
- La condition et l'action reçoivent [cible] : un joueur, un véhicule, un objet, ou un nom de marqueur.
- Les actions qui modifient quelque chose d'important (argent, objets, soins...) doivent passer par un remoteExec vers le serveur, qui re-vérifie la distance et les droits.

## Créer un point d'intérêt (distributeur, boutique, usine...)
    ["atm", "Distributeur", "int_atm", 3] call INT_fnc_registerPoint;      // type, libellé, préfixe des marqueurs, rayon en mètres
    ["atm_open", "Utiliser le distributeur", "point:atm", { true }, { /* ouvrir l'interface */ }, 10] call INT_fnc_registerAction;
Puis, dans l'éditeur Eden, place des marqueurs invisibles nommés int_atm_1, int_atm_2... à chaque emplacement.
