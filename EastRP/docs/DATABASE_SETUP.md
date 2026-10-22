# Mise en place de la base de données (Shadow PC, Windows)

Résultat attendu : le serveur Arma peut se connecter à une base MariaDB via l'extension extDB3,
et le journal du serveur (.rpt) contient des lignes "[CORE][DB]" qui montrent que ça marche.

## 1. Installer MariaDB
1. Télécharge l'installeur Windows (MSI) sur mariadb.org (Download > MariaDB Server, Windows x86_64).
2. Pendant l'installation : choisis un mot de passe pour l'utilisateur "root" (note-le), garde le port 3306,
   laisse l'option "Install as service" cochée. Garde HeidiSQL (outil graphique) s'il est proposé.

## 2. Créer la base et l'utilisateur
1. Ouvre HeidiSQL (menu Démarrer). Nouvelle session : hôte 127.0.0.1, utilisateur root, ton mot de passe, port 3306.
2. Ouvre le fichier db\01_create_database.sql (Fichier > Charger un fichier SQL), CHANGE le mot de passe
   'CHANGE_MOI_MOT_DE_PASSE' puis exécute (F9).
3. Fais la même chose avec db\02_schema.sql.
4. Vérifie dans HeidiSQL qu'une base "eastrp" avec une table "players" existe.

## 3. Installer extDB3
extDB3 est une extension (une DLL) qui permet à Arma de parler à MariaDB.
1. Récupère-la depuis l'archive GitHub : github.com/Sycholic/extDB3 (cherche les releases ou le dossier qui
   contient extDB3_x64.dll). ATTENTION : c'est un fichier exécutable. Ne le prends que sur cette source et
   regarde le nombre d'utilisateurs/avis. Dis-moi si tu ne trouves pas la version Windows.
2. Place le dossier dans le dossier du serveur : C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\@extDB3
   (il doit contenir extDB3_x64.dll et un fichier extdb3-conf.ini d'exemple).
3. Ouvre extdb3-conf.ini avec le Bloc-notes. Garde la structure du fichier fourni. Il doit contenir une section
   dont le nom est celui de ta base (utilise le nom : eastrp), avec ces valeurs :
       Type = MySQL
       Name = eastrp
       Username = eastrp
       Password = (le mot de passe choisi à l'étape 2)
       IP = 127.0.0.1
       Port = 3306
   Si le fichier d'exemple a des noms de champs différents, adapte les valeurs aux noms existants et dis-moi
   ce que tu vois.

## 4. Charger l'extension au démarrage du serveur
Dans server\config.bat, change :
    set MODS=@Maksniemi
en :
    set MODS=@Maksniemi;@extDB3

## 5. Lancer le test
1. Dans coreSystem\config\settings.hpp, mets dbTest = 1;
2. Relance start_server.bat (administrateur).
3. Ouvre le dernier .rpt dans server\profiles et copie-moi toutes les lignes qui contiennent "[CORE][DB]".

Selon ce que je lis, j'écris ensuite la vraie sauvegarde des joueurs (argent, objets, position) dans la base.
