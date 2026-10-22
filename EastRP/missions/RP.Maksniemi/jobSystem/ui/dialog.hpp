// Pôle Emploi : fenêtre construite par script (JOB_fnc_poleBuild)
class JOB_Pole
{
    idd = 75600;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[_this select 0] call JOB_fnc_poleBuild;";
    class ControlsBackground {};
    class Controls {};
};

// Mini-jeu de diagnostic (contrôle qualité, panne électrique) : fenêtre construite par script (JOB_fnc_quizBuild)
class JOB_QuizDlg
{
    idd = 75620;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[_this select 0] call JOB_fnc_quizBuild;";
    class ControlsBackground {};
    class Controls {};
};
