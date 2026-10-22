# Économie (module ECO) : distributeurs et boutiques

## Fonctionnement
- Approche un distributeur ou une boutique, regarde-le : « [TAB] Interagir - ... », puis le menu propose « Utiliser le distributeur » ou « Acheter ».
- Distributeur : dépôt et retrait entre tes espèces et ton compte. Le serveur vérifie la distance, le solde et le plafond par opération (`atmMaxPerOperation`). L'opération apparaît dans l'historique de l'application bancaire.
- Boutique : catalogue défini par type (voir `config/settings.hpp`, classe `ECO_Shops`). L'achat retire les espèces sur le serveur, puis l'objet arrive dans l'inventaire (au sol si l'inventaire est plein).

## Objets
- Avec le mod @EastRP : placer « Distributeur de billets », « Boutique : ... » ou « Caisse de magasin » depuis l'éditeur (catégorie EastRP).
- Sans le mod (tests) : les distributeurs du jeu (Land_Atm_01_F, Land_Atm_02_F) sont aussi reconnus.
- Changer le type d'une boutique : dans le champ Init de l'objet : `this setVariable ["eastrp_shop", "presse", true];`

## Ajouter un article ou un type de boutique
Dans `ECO_Shops` : copier un bloc `class xxx { displayName = "..."; item = "classe_du_jeu"; price = 20; };`.
Ne pas vendre ItemWatch ni ItemCompass (ils représentent la carte d'identité et le permis).

## Test rapide sans rien placer (devMode = 1)
Au démarrage du serveur, un distributeur (Land_Atm_01_F) et un kiosque-boutique (Land_Kiosk_blueking_F, type epicerie) sont créés
à 6 m et 12 m à l'est du marqueur spn_port. Désactivé automatiquement quand devMode = 0.
