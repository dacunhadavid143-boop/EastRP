/* COUCHE STOCKAGE : enregistre. params: [uid, paires]. (Remplaçable plus tard par une vraie base de données) */
params ["_uid", "_pairs"];
profileNamespace setVariable [format ["CORE_p_%1", _uid], _pairs];
CORE_dirty = true;
