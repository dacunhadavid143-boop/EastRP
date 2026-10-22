# Glossaire

Les termes techniques utilisés dans la documentation, expliqués simplement, avec où on les trouve dans le projet.

| Terme | Définition simple | Dans EastRP |
|---|---|---|
| **Arma 3 / SQF** | Jeu de simulation militaire et son langage de script. | Tout le code de la mission est en SQF. |
| **Mission** | Dossier de scripts et de configurations chargé par le serveur et téléchargé par les joueurs. | `missions/RP.Maksniemi/` |
| **Addon / PBO** | Paquet de contenu (objets, images, animations). Un PBO est une archive, un peu comme un zip. | `addons/eastrp_core/`, `tools/pbo.py` |
| **Client / serveur** | Le serveur est la machine centrale. Les clients sont les PC des joueurs. Leur mémoire n'est pas partagée. | Chaque fonction est marquée « côté client » ou « côté serveur ». |
| **Autorité serveur** | Seul le serveur décide de l'état du jeu. Le client demande, le serveur vérifie. | Argent, objets, étapes de métier. |
| **RPC (Remote Procedure Call)** | Appeler une fonction qui s'exécute sur une autre machine. | `remoteExec` |
| **Liste blanche (whitelist)** | On interdit tout sauf ce qui est explicitement autorisé. | `CfgRemoteExec` en `mode = 1`, fichiers `remoteExec.hpp` |
| **`remoteExecutedOwner`** | Sur le serveur, l'identifiant de la machine qui a vraiment envoyé l'appel. | Comparé au propriétaire de l'unité pour bloquer l'usurpation. |
| **Validation des entrées** | Vérifier toute donnée reçue (type, bornes, cohérence) avant de l'utiliser. | `CORE_fnc_changeMoney`, `ECO_fnc_srvBuy`, `JOB_fnc_srvStep` |
| **Espace de noms (namespace)** | Préfixe qui évite que deux parties du code utilisent le même nom. | Tags `CORE_`, `JOB_`, `PHN_`… |
| **HashMap (table de hachage)** | Structure clé → valeur avec accès très rapide, en temps constant. | `CORE_sessions` : identifiant du joueur → ses données |
| **Sérialisation** | Transformer des données en mémoire en un format enregistrable. | Paires `[clé, valeur]` dans `CORE_fnc_dbSave` |
| **Persistance** | Garder les données après un redémarrage. | Sauvegarde du profil serveur, MariaDB prévue |
| **Migration de données** | Convertir des données d'un ancien format vers le nouveau. | `CORE_fnc_dbLoad` convertit l'ancien format |
| **Couche d'abstraction / Repository** | Cacher le stockage derrière quelques fonctions pour pouvoir le changer facilement. | `dbLoad` / `dbSave` |
| **Write-behind / écriture différée** | Regrouper les écritures disque au lieu d'écrire à chaque changement. | `CORE_flushSoon`, sauvegarde toutes les 30 s |
| **Machine à états** | Système qui passe d'un état à l'autre selon des règles précises. | Cycle d'un métier : assign → step → sync |
| **Configuration déclarative** | Décrire le *quoi* en données et laisser le moteur gérer le *comment*. | Étapes des métiers dans `jobSystem/config/settings.hpp` |
| **Événement / publish-subscribe** | Un module annonce un événement, et ceux qui s'y sont abonnés réagissent. | `CORE_playerLoaded`, `SPN_spawned` |
| **Hook (crochet)** | Point où un autre module peut brancher sa propre fonction. | `SPN_preSpawnHooks` |
| **Registre de plugins** | Liste où les modules s'inscrivent pour ajouter une fonctionnalité. | `INT_fnc_registerAction`, `PHN_fnc_registerApp` |
| **Callback** | Fonction passée en paramètre pour être appelée plus tard. | Conditions et actions du menu TAB |
| **Polling (scrutation)** | Vérifier quelque chose à intervalle régulier dans une boucle. | HUD, détection de l'inventaire ouvert, repère des métiers |
| **Event handler** | Fonction déclenchée automatiquement par le moteur (touche, déconnexion, mort…). | `HandleDisconnect`, `EntityKilled`, `Draw3D` |
| **Lancer de rayon (raycast)** | Tracer une ligne invisible pour savoir ce qu'elle touche. | `lineIntersectsSurfaces` dans `INT_fnc_scan` |
| **RBAC** | Contrôle d'accès basé sur les rôles : chaque rôle a des permissions. | Panneau admin du téléphone |
| **Modèle push** | Le serveur envoie les nouvelles données au client sans qu'il les demande. | Messagerie du téléphone |
| **Idempotence** | Une opération qu'on peut répéter sans effet supplémentaire. | Fin d'appel téléphonique appelée deux fois sans erreur |
| **Signature numérique** | Clé privée pour signer, clé publique pour vérifier qu'un fichier n'a pas été modifié. | `modpack/` (`.biprivatekey` jamais publiée, `.bikey` publique) |
| **DXT5** | Format de compression d'image par blocs de 4×4 pixels, lu directement par la carte graphique. | `tools/paa.py` |
| **Retargeting d'animation** | Transférer un mouvement d'un squelette vers un autre. | `animations/transfert_animation.py` (Blender) |
| **FBX / RTM** | Formats d'animation : FBX est standard, RTM est le format d'Arma. | Pipeline DeepMotion → Blender → jeu |
| **IDD / IDC** | Identifiants numériques des fenêtres et des contrôles d'interface. | Une plage par module, voir `CONVENTIONS.md` |
| **postInit** | Fonction lancée automatiquement par le moteur après le chargement de la mission. | La fonction `init` de chaque module |
| **`.rpt`** | Fichier journal d'Arma : erreurs et messages `diag_log`. | Principal outil de débogage |
