class DOC_CardHUD
{
    idd = -1;
    duration = 12;
    fadeIn = 0.4;
    fadeOut = 0.6;
    movingEnable = 0;
    onLoad = "uiNamespace setVariable ['DOC_cardDisplay', _this select 0];";

    class controls
    {
        class Back : DOC_RscText
        {
            idc = 74301;
            x = "safeZoneX + 0.020"; y = "safeZoneY + 0.020"; w = 0.56; h = 0.4;
            colorBackground[] = {0.12,0.22,0.42,0.95};
        };
        class Band : DOC_RscText
        {
            idc = 74302;
            x = "safeZoneX + 0.020"; y = "safeZoneY + 0.020"; w = 0.56; h = 0.07;
            colorBackground[] = {0,0,0,0.35};
        };
        class Title : DOC_RscText
        {
            idc = 74303;
            x = "safeZoneX + 0.035"; y = "safeZoneY + 0.028"; w = 0.4; h = 0.032;
            sizeEx = 0.027; font = "PuristaBold";
        };
        class Country : DOC_RscText
        {
            idc = 74304;
            x = "safeZoneX + 0.035"; y = "safeZoneY + 0.060"; w = 0.4; h = 0.026;
            sizeEx = 0.02; colorText[] = {1,1,1,0.65};
        };
        class Number : DOC_RscText
        {
            idc = 74305;
            x = "safeZoneX + 0.320"; y = "safeZoneY + 0.032"; w = 0.245; h = 0.034;
            sizeEx = 0.03; style = 1; font = "EtelkaMonospacePro"; colorText[] = {1,0.85,0.5,1};
        };
        class Photo : DOC_RscPicture
        {
            idc = 74306;
            x = "safeZoneX + 0.035"; y = "safeZoneY + 0.110"; w = 0.12; h = 0.16;
            colorBackground[] = {0.8,0.8,0.82,1};
        };
        class PhotoTxt : DOC_RscText
        {
            idc = 74307;
            x = "safeZoneX + 0.035"; y = "safeZoneY + 0.175"; w = 0.12; h = 0.04;
            style = 2; sizeEx = 0.03; colorText[] = {0.35,0.35,0.4,1}; text = "ФОТО";
        };
        class Valid1 : DOC_RscText
        {
            idc = 74332;
            x = "safeZoneX + 0.032"; y = "safeZoneY + 0.280"; w = 0.14; h = 0.022;
            sizeEx = 0.018; colorText[] = {1,1,1,0.75};
        };
        class Valid2 : DOC_RscText
        {
            idc = 74333;
            x = "safeZoneX + 0.032"; y = "safeZoneY + 0.302"; w = 0.14; h = 0.022;
            sizeEx = 0.018; colorText[] = {1,1,1,0.75};
        };
        class Lbl0 : DOC_RscText
        {
            idc = 74310;
            x = "safeZoneX + 0.170"; y = "safeZoneY + 0.105"; w = 0.19; h = 0.03;
            sizeEx = 0.02; colorText[] = {1,1,1,0.6};
        };
        class Val0 : DOC_RscText
        {
            idc = 74320;
            x = "safeZoneX + 0.355"; y = "safeZoneY + 0.105"; w = 0.22; h = 0.03;
            sizeEx = 0.027; font = "PuristaBold";
        };
        class Lbl1 : DOC_RscText
        {
            idc = 74311;
            x = "safeZoneX + 0.170"; y = "safeZoneY + 0.137"; w = 0.19; h = 0.03;
            sizeEx = 0.02; colorText[] = {1,1,1,0.6};
        };
        class Val1 : DOC_RscText
        {
            idc = 74321;
            x = "safeZoneX + 0.355"; y = "safeZoneY + 0.137"; w = 0.22; h = 0.03;
            sizeEx = 0.027; font = "PuristaBold";
        };
        class Lbl2 : DOC_RscText
        {
            idc = 74312;
            x = "safeZoneX + 0.170"; y = "safeZoneY + 0.169"; w = 0.19; h = 0.03;
            sizeEx = 0.02; colorText[] = {1,1,1,0.6};
        };
        class Val2 : DOC_RscText
        {
            idc = 74322;
            x = "safeZoneX + 0.355"; y = "safeZoneY + 0.169"; w = 0.22; h = 0.03;
            sizeEx = 0.027; font = "PuristaBold";
        };
        class Lbl3 : DOC_RscText
        {
            idc = 74313;
            x = "safeZoneX + 0.170"; y = "safeZoneY + 0.201"; w = 0.19; h = 0.03;
            sizeEx = 0.02; colorText[] = {1,1,1,0.6};
        };
        class Val3 : DOC_RscText
        {
            idc = 74323;
            x = "safeZoneX + 0.355"; y = "safeZoneY + 0.201"; w = 0.22; h = 0.03;
            sizeEx = 0.027; font = "PuristaBold";
        };
        class Lbl4 : DOC_RscText
        {
            idc = 74314;
            x = "safeZoneX + 0.170"; y = "safeZoneY + 0.233"; w = 0.19; h = 0.03;
            sizeEx = 0.02; colorText[] = {1,1,1,0.6};
        };
        class Val4 : DOC_RscText
        {
            idc = 74324;
            x = "safeZoneX + 0.355"; y = "safeZoneY + 0.233"; w = 0.22; h = 0.03;
            sizeEx = 0.027; font = "PuristaBold";
        };
        class Lbl5 : DOC_RscText
        {
            idc = 74315;
            x = "safeZoneX + 0.170"; y = "safeZoneY + 0.265"; w = 0.19; h = 0.03;
            sizeEx = 0.02; colorText[] = {1,1,1,0.6};
        };
        class Val5 : DOC_RscText
        {
            idc = 74325;
            x = "safeZoneX + 0.355"; y = "safeZoneY + 0.265"; w = 0.22; h = 0.03;
            sizeEx = 0.027; font = "PuristaBold";
        };
        class Lbl6 : DOC_RscText
        {
            idc = 74316;
            x = "safeZoneX + 0.170"; y = "safeZoneY + 0.297"; w = 0.19; h = 0.03;
            sizeEx = 0.02; colorText[] = {1,1,1,0.6};
        };
        class Val6 : DOC_RscText
        {
            idc = 74326;
            x = "safeZoneX + 0.355"; y = "safeZoneY + 0.297"; w = 0.22; h = 0.03;
            sizeEx = 0.027; font = "PuristaBold";
        };
        class Mrz1 : DOC_RscText
        {
            idc = 74330;
            x = "safeZoneX + 0.035"; y = "safeZoneY + 0.340"; w = 0.53; h = 0.03;
            sizeEx = 0.024; font = "EtelkaMonospacePro"; colorText[] = {1,1,1,0.85};
        };
        class Mrz2 : DOC_RscText
        {
            idc = 74331;
            x = "safeZoneX + 0.035"; y = "safeZoneY + 0.370"; w = 0.53; h = 0.03;
            sizeEx = 0.024; font = "EtelkaMonospacePro"; colorText[] = {1,1,1,0.85};
        };
    };
};
