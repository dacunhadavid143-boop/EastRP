class INT_RscText
{
    type = 0; idc = -1; style = 0;
    x = 0; y = 0; w = 0.1; h = 0.04;
    font = "PuristaMedium"; sizeEx = 0.03; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    fixedWidth = 0; shadow = 0; linespacing = 1;
};

class INT_RscStruct
{
    type = 13; idc = -1; style = 0;
    x = 0; y = 0; w = 0.3; h = 0.1;
    size = 0.034; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0.6};
    class Attributes { font = "PuristaMedium"; color = "#ffffff"; align = "center"; valign = "middle"; shadow = 1; shadowColor = "#000000"; underline = 0; size = "1"; };
};

class INT_RscButton
{
    type = 1; idc = -1; style = 0;
    x = 0; y = 0; w = 0.3; h = 0.05;
    text = ""; font = "PuristaMedium"; sizeEx = 0.034; shadow = 0; default = 0;
    colorText[] = {1,1,1,1}; colorDisabled[] = {1,1,1,0.4};
    colorBackground[] = {0.13,0.13,0.15,0.95}; colorBackgroundDisabled[] = {0.1,0.1,0.1,0.5};
    colorBackgroundActive[] = {0.90,0.76,0.30,0.45}; colorFocused[] = {0.90,0.76,0.30,0.30};
    colorShadow[] = {0,0,0,0}; colorBorder[] = {0,0,0,0};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    offsetX = 0.01; offsetY = 0; offsetPressedX = 0.002; offsetPressedY = 0.002; borderSize = 0;
};
