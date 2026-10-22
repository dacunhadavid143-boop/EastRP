// UI du module SPN : classes préfixées SPN_, IDD 74100, IDC 74101-74109
class SPN_RscText
{
    type = 0; idc = -1; style = 0;
    x = 0; y = 0; w = 0.1; h = 0.04;
    font = "PuristaMedium"; sizeEx = 0.04; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    fixedWidth = 0; shadow = 1; linespacing = 1;
};

class SPN_RscStructuredText
{
    type = 13; idc = -1; style = 0;
    x = 0; y = 0; w = 0.3; h = 0.1;
    size = 0.035; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    class Attributes { font = "PuristaLight"; color = "#d8d8d8"; align = "left"; valign = "top"; shadow = 1; shadowColor = "#000000"; underline = 0; size = "1"; };
};

class SPN_RscButton
{
    type = 1; idc = -1; style = 2;
    x = 0; y = 0; w = 0.2; h = 0.05;
    text = ""; font = "PuristaMedium"; sizeEx = 0.045; shadow = 0; default = 0;
    colorText[] = {0.9,0.76,0.3,1}; colorDisabled[] = {1,1,1,0.3};
    colorBackground[] = {0,0,0,0.55}; colorBackgroundDisabled[] = {0,0,0,0.3};
    colorBackgroundActive[] = {0.9,0.76,0.3,0.35}; colorFocused[] = {0.9,0.76,0.3,0.2};
    colorShadow[] = {0,0,0,0}; colorBorder[] = {0.9,0.76,0.3,1};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    offsetX = 0; offsetY = 0; offsetPressedX = 0.002; offsetPressedY = 0.002; borderSize = 0.003;
};

class SPN_Dialog
{
    idd = 74100;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[_this select 0] call SPN_fnc_onLoad;";
    onKeyDown = "(_this select 1) == 1";   // bloque ECHAP

    class ControlsBackground
    {
        // Bandes cinéma haut et bas
        class TopBar : SPN_RscText
        {
            idc = 74108;
            x = "safeZoneX"; y = "safeZoneY"; w = "safeZoneW"; h = 0.12;
            colorBackground[] = {0,0,0,0.92};
        };
        class BottomBar : SPN_RscText
        {
            idc = 74109;
            x = "safeZoneX"; y = "safeZoneY + safeZoneH - 0.12"; w = "safeZoneW"; h = 0.12;
            colorBackground[] = {0,0,0,0.92};
        };
        // Voile sombre à gauche pour la lisibilité
        class Shade : SPN_RscText
        {
            x = "safeZoneX"; y = "safeZoneY + 0.12"; w = 0.75; h = "safeZoneH - 0.24";
            colorBackground[] = {0,0,0,0.35};
        };
    };

    class Controls
    {
        class ServerName : SPN_RscText
        {
            idc = 74101;
            x = "safeZoneX + 0.08"; y = "safeZoneY + 0.035"; w = 0.8; h = 0.05;
            sizeEx = 0.045; colorText[] = {0.9,0.76,0.3,1};
            text = "";
        };
        class Label : SPN_RscText
        {
            idc = 74106;
            x = "safeZoneX + 0.08"; y = "safeZoneY + 0.28"; w = 0.5; h = 0.04;
            sizeEx = 0.032; colorText[] = {1,1,1,0.6};
            text = "POINT D'ARRIVEE";
        };
        class Title : SPN_RscText
        {
            idc = 74102;
            x = "safeZoneX + 0.08"; y = "safeZoneY + 0.31"; w = 0.7; h = 0.2;
            font = "PuristaBold"; sizeEx = 0.17; colorText[] = {1,1,1,1};
            text = "";
        };
        class GoldLine : SPN_RscText
        {
            idc = 74107;
            x = "safeZoneX + 0.085"; y = "safeZoneY + 0.51"; w = 0.22; h = 0.004;
            colorBackground[] = {0.9,0.76,0.3,1};
        };
        class Description : SPN_RscStructuredText
        {
            idc = 74103;
            x = "safeZoneX + 0.08"; y = "safeZoneY + 0.53"; w = 0.45; h = 0.2;
            size = 0.042;
        };
        class Welcome : SPN_RscStructuredText
        {
            idc = 74104;
            x = "safeZoneX + 0.08"; y = "safeZoneY + safeZoneH - 0.095"; w = 0.4; h = 0.07;
            size = 0.045;
        };
        class EnterButton : SPN_RscButton
        {
            idc = 74105;
            text = "ENTRER EN VILLE";
            x = "safeZoneX + safeZoneW - 0.43"; y = "safeZoneY + safeZoneH - 0.095"; w = 0.35; h = 0.07;
            action = "[] spawn SPN_fnc_confirm;";
        };
    };
};
