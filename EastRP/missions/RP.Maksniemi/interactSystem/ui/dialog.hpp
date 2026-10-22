// Fenêtre vide : le menu d'interaction est construit par script (INT_fnc_menuBuild)
class INT_Menu
{
    idd = 75500;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[_this select 0] call INT_fnc_menuBuild;";
    onKeyDown = "_this call INT_fnc_menuKey";
    class ControlsBackground {};
    class Controls {};
};
