class DOC_RscText
{
    type = 0; idc = -1; style = 0;
    x = 0; y = 0; w = 0.1; h = 0.04;
    font = "PuristaMedium"; sizeEx = 0.03; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0,0,0,0};
    fixedWidth = 0; shadow = 0; linespacing = 1;
};

class DOC_RscStructuredText
{
    type = 13; idc = -1; style = 0;
    x = 0; y = 0; w = 0.3; h = 0.1;
    size = 0.03; text = "";
    colorText[] = {0.1,0.1,0.1,1}; colorBackground[] = {0,0,0,0};
    class Attributes { font = "PuristaLight"; color = "#222222"; align = "left"; valign = "top"; shadow = 0; shadowColor = "#000000"; underline = 0; size = "1"; };
};

class DOC_RscEdit
{
    type = 2; style = 0; idc = -1;
    x = 0; y = 0; w = 0.3; h = 0.04;
    font = "PuristaMedium"; sizeEx = 0.032; shadow = 0; text = ""; autocomplete = "";
    colorText[] = {0.08,0.12,0.45,1}; colorBackground[] = {0.97,0.95,0.88,1};
    colorSelection[] = {0.85,0.8,0.6,1}; colorDisabled[] = {0.3,0.3,0.3,1};
    canModify = 1;
};

class DOC_RscCombo
{
    type = 4; style = 0; idc = -1;
    x = 0; y = 0; w = 0.2; h = 0.04;
    font = "PuristaMedium"; sizeEx = 0.03; shadow = 0; wholeHeight = 0.4;
    colorText[] = {0.08,0.12,0.45,1}; colorBackground[] = {0.97,0.95,0.88,1};
    colorSelect[] = {0,0,0,1}; colorSelectBackground[] = {0.85,0.8,0.6,1};
    colorScrollbar[] = {0.08,0.12,0.45,1}; colorDisabled[] = {0.3,0.3,0.3,1};
    maxHistoryDelay = 1;
    soundSelect[] = {"",0.1,1}; soundExpand[] = {"",0.1,1}; soundCollapse[] = {"",0.1,1};
    arrowEmpty = "#(argb,8,8,3)color(0.08,0.12,0.45,1)"; arrowFull = "#(argb,8,8,3)color(0.08,0.12,0.45,1)";
    autoScrollSpeed = -1; autoScrollDelay = 5; autoScrollRewind = 0;
    class ComboScrollBar
    {
        color[] = {0.08,0.12,0.45,0.8}; colorActive[] = {0.08,0.12,0.45,1}; colorDisabled[] = {0.3,0.3,0.3,1};
        thumb = "#(argb,8,8,3)color(0.08,0.12,0.45,1)"; arrowEmpty = "#(argb,8,8,3)color(0.08,0.12,0.45,1)"; arrowFull = "#(argb,8,8,3)color(0.08,0.12,0.45,1)";
        border = "#(argb,8,8,3)color(0.08,0.12,0.45,1)";
        shadow = 0; scrollSpeed = 0.06; width = 0; height = 0;
        autoScrollEnabled = 0; autoScrollSpeed = -1; autoScrollDelay = 5; autoScrollRewind = 0;
    };
};

class DOC_RscButton
{
    type = 1; idc = -1; style = 2;
    x = 0; y = 0; w = 0.2; h = 0.05;
    text = ""; font = "PuristaMedium"; sizeEx = 0.032; shadow = 0; default = 0;
    colorText[] = {1,1,1,1}; colorDisabled[] = {1,1,1,0.3};
    colorBackground[] = {0.08,0.12,0.45,1}; colorBackgroundDisabled[] = {0.3,0.3,0.3,0.6};
    colorBackgroundActive[] = {0.15,0.2,0.65,1}; colorFocused[] = {0.15,0.2,0.65,1};
    colorShadow[] = {0,0,0,0}; colorBorder[] = {0,0,0,0};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    offsetX = 0; offsetY = 0; offsetPressedX = 0.002; offsetPressedY = 0.002; borderSize = 0;
};

class DOC_RscPicture
{
    type = 0; idc = -1; style = 48;
    x = 0; y = 0; w = 0.1; h = 0.1;
    font = "PuristaMedium"; sizeEx = 0.03; text = "";
    colorText[] = {1,1,1,1}; colorBackground[] = {0.8,0.8,0.82,1};
    shadow = 0; lineSpacing = 0;
};
