import RscMapControl;   // classe de mini-carte du jeu (utilisée par le GPS)
class JOB_RscText
{
    type = 0; idc = -1; style = 0;
    x = 0; y = 0; w = 0.1; h = 0.04;
    font = "PuristaMedium"; sizeEx = 0.032; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    fixedWidth = 0; shadow = 0; linespacing = 1;
};
class JOB_RscButton
{
    type = 1; idc = -1; style = 2;
    x = 0; y = 0; w = 0.2; h = 0.05;
    text = ""; font = "PuristaMedium"; sizeEx = 0.034; shadow = 0; default = 0;
    colorText[] = {1,1,1,1}; colorDisabled[] = {1,1,1,0.35};
    colorBackground[] = {0.20,0.22,0.27,1}; colorBackgroundDisabled[] = {0.12,0.12,0.14,0.8};
    colorBackgroundActive[] = {0.90,0.76,0.30,0.55}; colorFocused[] = {0.90,0.76,0.30,0.30};
    colorShadow[] = {0,0,0,0}; colorBorder[] = {0,0,0,0};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    offsetX = 0; offsetY = 0; offsetPressedX = 0.002; offsetPressedY = 0.002; borderSize = 0;
};
class JOB_RscStructured
{
    type = 13; idc = -1; style = 0;
    x = 0; y = 0; w = 0.3; h = 0.1;
    size = 0.034; text = "";
    colorBackground[] = {0,0,0,0};
    shadow = 0;
    class Attributes { font = "PuristaMedium"; color = "#ffffff"; colorLink = "#ffffff"; align = "left"; shadow = 0; };
};
class JOB_RscPicture
{
    type = 0; idc = -1; style = 48;
    x = 0; y = 0; w = 0.2; h = 0.2;
    font = "PuristaMedium"; sizeEx = 0.03; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    fixedWidth = 0; shadow = 0; linespacing = 1;
};
