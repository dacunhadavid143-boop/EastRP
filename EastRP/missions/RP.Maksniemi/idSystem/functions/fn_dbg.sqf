/* Journal de diagnostic (affiché dans le chat à la fermeture de l'inventaire). params: [message] */
params ["_m"];
if (!DOC_debug) exitWith {};
DOC_dbg pushBack _m;
diag_log ("[DOC] " + _m);
