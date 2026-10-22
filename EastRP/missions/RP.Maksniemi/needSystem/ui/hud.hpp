class NEED_HUD
{
    idd = -1;
    duration = 1e+011;
    fadeIn = 0; fadeOut = 0;
    movingEnable = 0;
    onLoad = "uiNamespace setVariable ['NEED_hudDisplay', _this select 0];";
    class controls
    {
        class Panel : NEED_RscText
        {
            x = "safeZoneX + safeZoneW - 0.27 + 0"; y = "safeZoneY + safeZoneH - 0.30 + 0"; w = 0.25; h = 0.14;
            colorBackground[] = {0,0,0,0.35};
        };
        class Lbl0 : NEED_RscText
        {
            idc = 75301;
            x = "safeZoneX + safeZoneW - 0.27 + 0.012"; y = "safeZoneY + safeZoneH - 0.30 + 0.012"; w = 0.08; h = 0.035;
            text = "SANTE";
        };
        class BarBack0 : NEED_RscText
        {
            x = "safeZoneX + safeZoneW - 0.27 + 0.095"; y = "safeZoneY + safeZoneH - 0.30 + 0.020999999999999998"; w = 0.145; h = 0.018;
            colorBackground[] = {1,1,1,0.15};
        };
        class Bar0 : NEED_RscText
        {
            idc = 75302;
            x = "safeZoneX + safeZoneW - 0.27 + 0.095"; y = "safeZoneY + safeZoneH - 0.30 + 0.020999999999999998"; w = 0.145; h = 0.018;
            colorBackground[] = {0.85,0.2,0.2,1};
        };
        class Lbl1 : NEED_RscText
        {
            idc = 75303;
            x = "safeZoneX + safeZoneW - 0.27 + 0.012"; y = "safeZoneY + safeZoneH - 0.30 + 0.054000000000000006"; w = 0.08; h = 0.035;
            text = "FAIM";
        };
        class BarBack1 : NEED_RscText
        {
            x = "safeZoneX + safeZoneW - 0.27 + 0.095"; y = "safeZoneY + safeZoneH - 0.30 + 0.063"; w = 0.145; h = 0.018;
            colorBackground[] = {1,1,1,0.15};
        };
        class Bar1 : NEED_RscText
        {
            idc = 75304;
            x = "safeZoneX + safeZoneW - 0.27 + 0.095"; y = "safeZoneY + safeZoneH - 0.30 + 0.063"; w = 0.145; h = 0.018;
            colorBackground[] = {0.95,0.6,0.15,1};
        };
        class Lbl2 : NEED_RscText
        {
            idc = 75305;
            x = "safeZoneX + safeZoneW - 0.27 + 0.012"; y = "safeZoneY + safeZoneH - 0.30 + 0.096"; w = 0.08; h = 0.035;
            text = "SOIF";
        };
        class BarBack2 : NEED_RscText
        {
            x = "safeZoneX + safeZoneW - 0.27 + 0.095"; y = "safeZoneY + safeZoneH - 0.30 + 0.105"; w = 0.145; h = 0.018;
            colorBackground[] = {1,1,1,0.15};
        };
        class Bar2 : NEED_RscText
        {
            idc = 75306;
            x = "safeZoneX + safeZoneW - 0.27 + 0.095"; y = "safeZoneY + safeZoneH - 0.30 + 0.105"; w = 0.145; h = 0.018;
            colorBackground[] = {0.25,0.6,0.95,1};
        };
    };
};
