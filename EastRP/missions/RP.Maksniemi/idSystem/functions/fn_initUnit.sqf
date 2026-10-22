/* Initialisation de l'unité (réservé aux futurs besoins). Les actions du menu molette ont été retirées :
   les papiers sont des objets physiques : double-clic dans l'inventaire pour les montrer. params: [unit] */
params ["_unit"];
if (_unit getVariable ["DOC_init", false]) exitWith {};
_unit setVariable ["DOC_init", true];
