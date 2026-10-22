/* Exemples de test (uniquement si devMode = 1 dans CORE_Settings) :
   - un point "test" : place un marqueur nommé int_test_1 (n'importe quel type) dans l'éditeur, puis approche-toi à 3 m ;
   - une action sur n'importe quel objet visé (à moins de 3 m) ;
   - une action sur un PNJ (personnage non joueur) proche. */
if (getNumber (missionConfigFile >> "CORE_Settings" >> "devMode") != 1) exitWith {};
["test", "Point de test", "int_test", 3] call INT_fnc_registerPoint;
["int_demo_point", "Test d'interaction (point)", "point:test", { true }, { params ["_m"]; systemChat format ["[INT] Interaction avec le marqueur %1", _m]; }, 90] call INT_fnc_registerAction;
["int_demo_obj", "Inspecter (test)", "object", { true }, { params ["_o"]; systemChat format ["[INT] Objet : %1", typeOf _o]; }, 91] call INT_fnc_registerAction;
["int_demo_npc", "Parler (test)", "npc", { true }, { params ["_n"]; systemChat format ["[INT] Vous parlez à un personnage (%1).", typeOf _n]; }, 92] call INT_fnc_registerAction;
