class PHN_RscText
{
    type = 0; idc = -1; style = 0;
    x = 0; y = 0; w = 0.1; h = 0.04;
    font = "PuristaMedium"; sizeEx = 0.03; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    fixedWidth = 0; shadow = 0; linespacing = 1;
};
class PHN_RscTextC : PHN_RscText { style = 2; };
class PHN_RscTextR : PHN_RscText { style = 1; };

class PHN_RscStruct
{
    type = 13; idc = -1; style = 0;
    x = 0; y = 0; w = 0.3; h = 0.1;
    size = 0.03; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    class Attributes { font = "PuristaMedium"; color = "#ffffff"; align = "left"; valign = "top"; shadow = 0; shadowColor = "#000000"; underline = 0; size = "1"; };
};

class PHN_RscEdit
{
    type = 2; style = 0; idc = -1;
    x = 0; y = 0; w = 0.3; h = 0.04;
    font = "PuristaMedium"; sizeEx = 0.03; shadow = 0; text = ""; autocomplete = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    colorSelection[] = {0.3,0.5,0.9,0.6}; colorDisabled[] = {1,1,1,0.4};
    canModify = 1;
};

class PHN_RscButtonFlat
{
    type = 1; idc = -1; style = 2;
    x = 0; y = 0; w = 0.1; h = 0.05;
    text = ""; font = "PuristaMedium"; sizeEx = 0.03; shadow = 0; default = 0;
    colorText[] = {1,1,1,1}; colorDisabled[] = {1,1,1,0.4};
    colorBackground[] = {0,0,0,0}; colorBackgroundDisabled[] = {0,0,0,0};
    colorBackgroundActive[] = {1,1,1,0.14}; colorFocused[] = {0,0,0,0};
    colorShadow[] = {0,0,0,0}; colorBorder[] = {0,0,0,0};
    soundEnter[] = {"",0.1,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundClick[] = {"",0.1,1};
    soundEscape[] = {"",0.1,1};
    offsetX = 0; offsetY = 0; offsetPressedX = 0; offsetPressedY = 0; borderSize = 0;
};

class PHN_RscPicture
{
    type = 0; idc = -1; style = 48;
    x = 0; y = 0; w = 0.1; h = 0.1;
    font = "PuristaMedium"; sizeEx = 0.03; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    shadow = 0; lineSpacing = 1; fixedWidth = 0;
};
