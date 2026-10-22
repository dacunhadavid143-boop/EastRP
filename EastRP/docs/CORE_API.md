# API du noyau (module CORE)

Inventaire **uniquement physique** : ce que le joueur possède, c'est ce qui est dans son inventaire Arma
(armes, chargeurs, uniforme, gilet, sac, objets). Il n'existe pas d'inventaire virtuel.
Le noyau sauvegarde et restitue cet équipement (getUnitLoadout / setUnitLoadout) ainsi que la position.
Mort : équipement et position sauvegardés sont effacés, l'argent est conservé.

Fonctions serveur (le client ne modifie jamais son argent directement) :
| Fonction | Rôle |
|----------|------|
| `[unit, "cash"|"bank", delta] call CORE_fnc_changeMoney` | ajoute (+) ou retire (-). `false` si impossible (solde insuffisant) |
| `[unit, "cash"|"bank"] call CORE_fnc_getMoney` | lit un solde |

Événements : serveur `CORE_playerLoaded [unit, uid]` ; client `CORE_loadoutApplied [unit]` (équipement restauré).
Stockage : tout passe par `CORE_fnc_dbLoad` / `CORE_fnc_dbSave` (profil du serveur pour l'instant, base de données ensuite).
Base de données : voir docs/DATABASE_SETUP.md et le dossier db/.
