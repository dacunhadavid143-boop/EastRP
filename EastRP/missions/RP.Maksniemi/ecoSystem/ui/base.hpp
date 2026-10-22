class ECO_RscText
{
    type = 0; idc = -1; style = 0;
    x = 0; y = 0; w = 0.1; h = 0.04;
    font = "PuristaMedium"; sizeEx = 0.032; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    fixedWidth = 0; shadow = 0; linespacing = 1;
};
class ECO_RscTextR : ECO_RscText { style = 1; };

class ECO_RscEdit
{
    type = 2; style = 0; idc = -1;
    x = 0; y = 0; w = 0.3; h = 0.045;
    font = "PuristaMedium"; sizeEx = 0.036; shadow = 0; text = ""; autocomplete = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0.15,0.15,0.18,1};
    colorSelection[] = {0.9,0.76,0.3,0.6}; colorDisabled[] = {1,1,1,0.4};
    canModify = 1;
};

class ECO_RscButton
{
    type = 1; idc = -1; style = 2;
    x = 0; y = 0; w = 0.2; h = 0.05;
    text = ""; font = "PuristaMedium"; sizeEx = 0.034; shadow = 0; default = 0;
    colorText[] = {1,1,1,1}; colorDisabled[] = {1,1,1,0.4};
    colorBackground[] = {0.20,0.22,0.27,1}; colorBackgroundDisabled[] = {0.1,0.1,0.1,0.5};
    colorBackgroundActive[] = {0.90,0.76,0.30,0.55}; colorFocused[] = {0.90,0.76,0.30,0.30};
    colorShadow[] = {0,0,0,0}; colorBorder[] = {0,0,0,0};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    offsetX = 0; offsetY = 0; offsetPressedX = 0.002; offsetPressedY = 0.002; borderSize = 0;
};
