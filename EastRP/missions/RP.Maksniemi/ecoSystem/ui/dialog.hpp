// Fenêtre vide : distributeur et boutique sont construits par script (ECO_fnc_panelBuild)
class ECO_Panel
{
    idd = 74500;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[_this select 0] call ECO_fnc_panelBuild;";
    class ControlsBackground {};
    class Controls {};
};
