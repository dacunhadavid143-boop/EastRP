// Fenêtre vide : tout le téléphone est dessiné par script (PHN_fnc_build), ce qui permet d'ajouter des applications sans toucher à la config.
class PHN_Phone
{
    idd = 75400;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[_this select 0] call PHN_fnc_build;";
    onUnload = "PHN_open = false;";
    onKeyDown = "_this call PHN_fnc_onKey";
    class ControlsBackground
    {
        class Dim : PHN_RscText
        {
            x = "safeZoneX"; y = "safeZoneY"; w = "safeZoneW"; h = "safeZoneH";
            colorBackground[] = {0,0,0,0.35};
        };
    };
    class Controls {};
};
