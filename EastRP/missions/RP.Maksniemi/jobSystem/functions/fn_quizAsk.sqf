/* CLIENT : affiche le mini-jeu (situation + boutons de réponse) et attend le choix du joueur.
   params: [titre, [texte, [réponses]]] -> numéro de la réponse choisie, ou -1 si la fenêtre est fermée. À appeler dans un spawn. */
params ["_title", ["_q", []]];
_q params [["_txt", ""], ["_ans", []], ["_rows", []]];
if (_ans isEqualTo []) exitWith { -1 };
JOB_quizData = [_title, _txt, _ans, _rows];
JOB_quizRes = -2;
createDialog "JOB_QuizDlg";
waitUntil { uiSleep 0.05; JOB_quizRes != -2 || {isNull findDisplay 75620} };
uiSleep 0.05;
if (JOB_quizRes < 0) exitWith { -1 };
JOB_quizRes
