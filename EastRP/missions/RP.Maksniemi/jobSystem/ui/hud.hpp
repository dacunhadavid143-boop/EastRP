// GPS : mini-carte affichée en surimpression (calque RscTitles), centrée sur le joueur par JOB_fnc_gps
class JOB_GpsHud
{
    idd = 75610;
    duration = 1e10;
    fadeIn = 0;
    fadeOut = 0;
    movingEnable = 0;
    onLoad = "uiNamespace setVariable ['JOB_gpsDisp', _this select 0];";
    onUnload = "uiNamespace setVariable ['JOB_gpsDisp', displayNull];";
    class controls
    {
        class Bg: JOB_RscText
        {
            idc = 75611;
            x = "safeZoneX + safeZoneW - 324 * pixelW";
            y = "safeZoneY + safeZoneH - 444 * pixelH";
            w = "308 * pixelW";
            h = "334 * pixelH";
            colorBackground[] = {0.05, 0.06, 0.08, 0.9};
        };
        class Title: JOB_RscText
        {
            idc = 75612;
            x = "safeZoneX + safeZoneW - 320 * pixelW";
            y = "safeZoneY + safeZoneH - 442 * pixelH";
            w = "300 * pixelW";
            h = "26 * pixelH";
            font = "PuristaBold";
            sizeEx = "22 * pixelH";
            colorText[] = {0.95, 0.55, 0.12, 1};
            text = "GPS";
        };
        class Map: RscMapControl
        {
            idc = 75613;
            x = "safeZoneX + safeZoneW - 320 * pixelW";
            y = "safeZoneY + safeZoneH - 410 * pixelH";
            w = "300 * pixelW";
            h = "300 * pixelH";
            scaleDefault = 0.09;
            scaleMin = 0.01;
            scaleMax = 1;
        };
    };
};
