/* Application de discussion : point d'entrée (première connexion si le joueur n'est pas inscrit) */
if !(player getVariable ["PHN_waReg", false]) exitWith { [PHN_fnc_pgWaWelcome, []] call PHN_fnc_showPage; };
[[PHN_fnc_pgWaStatus, PHN_fnc_pgWaChats, PHN_fnc_pgWaYou] select PHN_waTab, []] call PHN_fnc_showPage;
