# Documentation EastRP

## Par où commencer

1. [**ARCHITECTURE.md**](ARCHITECTURE.md) : la vue d'ensemble (client/serveur, sécurité, modules, données).
2. [**JOURNAL_DEV.md**](JOURNAL_DEV.md) : bugs marquants et comment ils ont été résolus.
3. [**GLOSSAIRE.md**](GLOSSAIRE.md) : tous les termes techniques expliqués.

## Modules

Chaque fiche contient :

- les concepts informatiques démontrés ;
- un schéma du fonctionnement ;
- **chaque fonction expliquée** *dans le jeu* et *en informatique* ;
- les points de sécurité et les limites.

| # | Fiche | Module | Contenu |
|---|---|---|---|
| 1 | [01_spawn](modules/01_spawn.md) | `SPN` | Écran d'apparition, caméra, hooks avant l'apparition |
| 2 | [02_identite](modules/02_identite.md) | `DOC` | Formulaire d'identité, carte, permis, intégration à l'inventaire |
| 3 | [03_core](modules/03_core.md) | `CORE` | Noyau : sessions, argent, stockage, sauvegarde |
| 4 | [04_besoins](modules/04_besoins.md) | `NEED` | Faim, soif, consommation validée par le serveur |
| 5 | [05_interaction](modules/05_interaction.md) | `INT` | Menu TAB, registre d'actions, lancer de rayon |
| 6 | [06_economie](modules/06_economie.md) | `ECO` | Boutiques, distributeurs |
| 7 | [07_metiers](modules/07_metiers.md) | `JOB` | Pôle Emploi, machine à états des métiers, usine, contrôle qualité |
| 8 | [08_telephone](modules/08_telephone.md) | `PHN` | Téléphone : composants UI, banque, messagerie, appels, admin |
| 9 | [09_addon_et_outils](modules/09_addon_et_outils.md) | — | Addon, textures DXT5, PBO, pipeline d'animation Blender |
| 10 | [10_deploiement](modules/10_deploiement.md) | — | Modpack, signature numérique, serveur dédié, base de données |

## Documents d'origine du projet

- [CONVENTIONS.md](CONVENTIONS.md) : règles de code communes à tous les modules.
- [CORE_API.md](CORE_API.md) : interface publique du noyau.
- [DATABASE_SETUP.md](DATABASE_SETUP.md) : procédure d'installation de MariaDB et extDB3.
