# Journal de développement : bugs marquants et solutions

Les recruteurs adorent la question « raconte-moi un bug difficile ». Voici les vrais problèmes rencontrés sur EastRP. Chacun suit le même plan : **symptôme → enquête → cause → correction → leçon**.

## Méthode de test utilisée

- **Tests en jeu systématiques** après chaque modification, sur un serveur dédié local.
- **Journaux `.rpt`** (serveur et client) : recherche des lignes d'erreur et des messages `diag_log` préfixés par module (`[CORE]`, `[JOB]`…).
- **Vidéos de test** découpées en images toutes les 3 secondes pour voir précisément à quel moment ça se passe mal.
- **Modes diagnostic activables** dans les réglages (`debug = 1`), qui affichent dans le chat ce que le système « voit », par exemple `[INT debug]` pour le menu TAB.

---

## 1. Les sauvegardes qui ne se rechargeaient pas

- **Symptôme :** après une reconnexion, certaines données du joueur étaient perdues.
- **Enquête :** lecture de ce qui était réellement écrit dans le profil du serveur.
- **Cause :** les données étaient enregistrées en **deux listes séparées** (toutes les clés, puis toutes les valeurs) au lieu d'une liste de paires `[clé, valeur]`. Le chargement ne les reconnaissait pas.
- **Correction :** nouveau format en paires, et **migration automatique** dans `CORE_fnc_dbLoad`. Si l'ancien format est détecté, il est converti au chargement, sans rien perdre.
- **Leçon :** quand on change un format de données, on prévoit la migration des données existantes.

## 2. L'animation de l'électricien ne se jouait pas

- **Symptôme :** le personnage restait debout. Aucune animation, aucune erreur.
- **Enquête :** plusieurs fausses pistes (manette, entrées clavier, mods) ont été éliminées une à une, puis on est revenu à l'état d'animation lui-même.
- **Causes (deux à la fois) :**
  1. Le fichier `.rtm` était décalé d'environ 1 m vers le bas. Le squelette d'Arma a son origine au **bassin**, pas aux pieds. Il a fallu recaler l'animation au sol.
  2. L'état d'animation **héritait** d'un réglage du parent (`actions = "CivilStandActions"`) qui ramenait immédiatement le joueur en position debout.
- **Correction :** recalage de l'animation, puis `actions = "NoActions"` et `minPlayTime = 1` dans la configuration de l'addon.
- **Leçon :** avec l'héritage, un comportement peut venir du parent sans être écrit dans la classe enfant. Il faut toujours vérifier ce qu'on hérite.

## 3. « Missing ; » à la ligne 27

- **Symptôme :** tout le module Métiers était cassé après une modification. Le journal indiquait une erreur de syntaxe.
- **Cause :** un remplacement de texte automatisé avait modifié la **première occurrence** d'une ligne qui apparaissait deux fois, et pas celle qui était visée. Une déclaration de variable s'est retrouvée coupée.
- **Correction :** restauration de la ligne `private _rad = if ... then ... else ...` au bon endroit.
- **Leçon :** une modification doit cibler un contexte unique. Après chaque changement, on relance et on lit le journal.

## 4. Deux classes avec le même nom

- **Symptôme :** le quiz des métiers ne s'ouvrait pas correctement.
- **Cause :** le nom `JOB_Quiz` désignait à la fois la **banque de questions** (dans les réglages) et la **fenêtre** (dans l'interface). Les deux vivent dans le même espace de configuration, donc l'une écrasait l'autre.
- **Correction :** la fenêtre a été renommée `JOB_QuizDlg`.
- **Leçon :** les espaces de noms concernent aussi les classes de configuration, pas seulement les fonctions.

## 5. Les machines de l'usine étaient invisibles

- **Symptôme :** les objets (machine CNC, ligne, bennes) étaient visibles dans l'éditeur mais absents en jeu.
- **Enquête :**
  - Le journal du client montrait que les objets **existaient** : le module Métiers trouvait bien `job_usine_cnc_1`, etc.
  - Les mods de ces objets étaient bien chargés.
  - Le script de masquage du décor ne touche que les objets de la carte, pas ceux de la mission.
  - Restait le fichier de mission. Il est **binaire**, donc on l'a lu avec un petit script Python pour extraire les attributs des objets.
- **Cause :** l'attribut **« Afficher le modèle »** avait été décoché par erreur dans l'éditeur, en même temps que les dégâts et la simulation. L'éditeur affiche quand même l'objet, mais le jeu le cache.
- **Correction :** recocher la case, sans aucun changement de code.
- **Leçon :** avant d'accuser le code, il faut vérifier les données. Procéder par élimination, en confirmant chaque hypothèse par une preuve (journal, fichier), est ce qui a permis de trouver.

## 6. La touche TAB ne proposait rien devant la bonne caisse

- **Symptôme :** devant la caisse de stock, le menu d'interaction restait vide.
- **Cause :** le menu détecte l'objet visé par un **lancer de rayon** depuis les yeux du joueur. La caisse était dans une **pile** d'autres caisses, non nommées, et le rayon touchait la voisine. Certains objets de mods n'ont pas non plus de surface détectable.
- **Correction :** dans `INT_fnc_scan`, si un objet de travail (`job_…`) se trouve à moins de 4 m, il est **prioritaire** sur ce que touche le rayon.
- **Leçon :** une détection « parfaite » sur le papier peut échouer avec de vraies données. Il faut une règle de repli (*fallback*).

## 7. Faire réfléchir le joueur sans lui donner la réponse

- **Problème de conception :** au contrôle qualité, le joueur doit décider si une pompe est conforme. Si le client connaissait la bonne réponse, un tricheur pourrait la lire.
- **Solution :** le **serveur** génère la fiche, aléatoire avec 50 % de pompes défectueuses, et garde la bonne réponse. Le client ne reçoit que les mesures à afficher. Le serveur compare la décision, applique une pénalité en cas d'erreur, puis indique où déposer la pompe selon la décision du joueur (expédition si validée, rebut si refusée).
- **Leçon :** une information qui donne un avantage ne doit jamais quitter le serveur.

---

## Ce qui reste à faire (dette technique assumée)

- Brancher MariaDB à la place du profil serveur.
- Remettre les valeurs de production (XP requise, durée de contrat, modes test et debug).
- Activer `verifySignatures` et BattlEye pour l'ouverture publique.
- Supprimer le code mort et les fonctions dupliquées relevées dans les fiches.
- Sauvegarder le stock de pompes de l'usine, qui est remis à zéro au redémarrage du serveur.
