class DOC_FormDialog
{
    idd = 74200;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[_this select 0] call DOC_fnc_formOnLoad;";

    class ControlsBackground
    {
        class Dim : DOC_RscText { x = "safeZoneX"; y = "safeZoneY"; w = "safeZoneW"; h = "safeZoneH"; colorBackground[] = {0,0,0,0.6}; };
        class Shadow : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3650 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.4400 * (safeZoneH*1.03)"; w = "0.7300 * (safeZoneH*1.03)"; h = "0.8800 * (safeZoneH*1.03)";
            colorBackground[] = {0,0,0,0.5};
        };
        class Paper : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3600 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.4350 * (safeZoneH*1.03)"; w = "0.7200 * (safeZoneH*1.03)"; h = "0.8700 * (safeZoneH*1.03)";
            colorBackground[] = {0.93,0.9,0.8,1};
        };
        class Border : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3480 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.4230 * (safeZoneH*1.03)"; w = "0.6960 * (safeZoneH*1.03)"; h = "0.0020 * (safeZoneH*1.03)";
            colorBackground[] = {0.08,0.12,0.45,0.7};
        };
        class Border2 : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3480 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + 0.4230 * (safeZoneH*1.03)"; w = "0.6960 * (safeZoneH*1.03)"; h = "0.0020 * (safeZoneH*1.03)";
            colorBackground[] = {0.08,0.12,0.45,0.7};
        };
        class TitleSmall : DOC_RscText
        {
            idc = 74226;
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.4100 * (safeZoneH*1.03)"; w = "0.6400 * (safeZoneH*1.03)"; h = "0.0300 * (safeZoneH*1.03)";
            sizeEx = "0.024 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; style = 2; text = "";
        };
        class Title : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.3830 * (safeZoneH*1.03)"; w = "0.6400 * (safeZoneH*1.03)"; h = "0.0450 * (safeZoneH*1.03)";
            sizeEx = "0.04 * (safeZoneH*1.03)"; font = "PuristaBold"; style = 2; colorText[] = {0.08,0.12,0.45,1}; text = "DEMANDE DE DOCUMENTS D'IDENTITE";
        };
        class TitleRu : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.3430 * (safeZoneH*1.03)"; w = "0.6400 * (safeZoneH*1.03)"; h = "0.0300 * (safeZoneH*1.03)";
            sizeEx = "0.024 * (safeZoneH*1.03)"; style = 2; colorText[] = {0.15,0.15,0.15,1}; text = "ЗАЯВЛЕНИЕ НА ПОЛУЧЕНИЕ УДОСТОВЕРЕНИЯ ЛИЧНОСТИ";
        };
        class FormNo : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.4130 * (safeZoneH*1.03)"; w = "0.3000 * (safeZoneH*1.03)"; h = "0.0250 * (safeZoneH*1.03)";
            sizeEx = "0.02 * (safeZoneH*1.03)"; colorText[] = {0.6,0.1,0.1,1}; text = "Formulaire N° 14-B";
        };
        class Date : DOC_RscText
        {
            idc = 74225;
            x = "(safeZoneX + safeZoneW/2) + 0.0400 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.4130 * (safeZoneH*1.03)"; w = "0.2800 * (safeZoneH*1.03)"; h = "0.0250 * (safeZoneH*1.03)";
            sizeEx = "0.02 * (safeZoneH*1.03)"; style = 1; colorText[] = {0.6,0.1,0.1,1}; text = "";
        };
    };

    class Controls
    {
        class Lbl0 : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.3000 * (safeZoneH*1.03)"; w = "0.3300 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.021 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; text = "NOM / ФАМИЛИЯ";
        };
        class Fld0 : DOC_RscText
        {
            idc = 74211;
            x = "(safeZoneX + safeZoneW/2) + 0.0150 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.3000 * (safeZoneH*1.03)"; w = "0.3200 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.034 * (safeZoneH*1.03)"; font = "PuristaBold"; colorText[] = {0.08,0.12,0.45,1};
        };
        class Lbl1 : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.2500 * (safeZoneH*1.03)"; w = "0.3300 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.021 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; text = "PRENOM / ИМЯ";
        };
        class Fld1 : DOC_RscText
        {
            idc = 74212;
            x = "(safeZoneX + safeZoneW/2) + 0.0150 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.2500 * (safeZoneH*1.03)"; w = "0.3200 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.034 * (safeZoneH*1.03)"; font = "PuristaBold"; colorText[] = {0.08,0.12,0.45,1};
        };
        class Lbl2 : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.2000 * (safeZoneH*1.03)"; w = "0.3300 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.021 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; text = "SEXE / ПОЛ";
        };
        class Fld2 : DOC_RscCombo
        {
            sizeEx = "0.03 * (safeZoneH*1.03)";
            idc = 74213;
            x = "(safeZoneX + safeZoneW/2) + 0.0150 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.2000 * (safeZoneH*1.03)"; w = "0.3200 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
        };
        class Lbl3 : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.1500 * (safeZoneH*1.03)"; w = "0.3300 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.021 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; text = "DATE DE NAISSANCE / ДАТА РОЖДЕНИЯ";
        };
        class Day : DOC_RscCombo
        {
            sizeEx = "0.03 * (safeZoneH*1.03)";
            idc = 74214;
            x = "(safeZoneX + safeZoneW/2) + 0.0150 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.1500 * (safeZoneH*1.03)"; w = "0.0750 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
        };
        class Month : DOC_RscCombo
        {
            sizeEx = "0.03 * (safeZoneH*1.03)";
            idc = 74215;
            x = "(safeZoneX + safeZoneW/2) + 0.0950 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.1500 * (safeZoneH*1.03)"; w = "0.1400 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
        };
        class Year : DOC_RscCombo
        {
            sizeEx = "0.03 * (safeZoneH*1.03)";
            idc = 74216;
            x = "(safeZoneX + safeZoneW/2) + 0.2400 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.1500 * (safeZoneH*1.03)"; w = "0.0950 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
        };
        class Lbl4 : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.1000 * (safeZoneH*1.03)"; w = "0.3300 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.021 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; text = "LIEU DE NAISSANCE / МЕСТО РОЖДЕНИЯ";
        };
        class Fld4 : DOC_RscCombo
        {
            sizeEx = "0.03 * (safeZoneH*1.03)";
            idc = 74217;
            x = "(safeZoneX + safeZoneW/2) + 0.0150 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.1000 * (safeZoneH*1.03)"; w = "0.3200 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
        };
        class Lbl5 : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.0500 * (safeZoneH*1.03)"; w = "0.3300 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.021 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; text = "TAILLE (cm) / РОСТ";
        };
        class Fld5 : DOC_RscCombo
        {
            sizeEx = "0.03 * (safeZoneH*1.03)";
            idc = 74218;
            x = "(safeZoneX + safeZoneW/2) + 0.0150 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.0500 * (safeZoneH*1.03)"; w = "0.3200 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
        };
        class Lbl6 : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.0000 * (safeZoneH*1.03)"; w = "0.3300 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.021 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; text = "COULEUR DES YEUX / ЦВЕТ ГЛАЗ";
        };
        class Fld6 : DOC_RscCombo
        {
            sizeEx = "0.03 * (safeZoneH*1.03)";
            idc = 74219;
            x = "(safeZoneX + safeZoneW/2) + 0.0150 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + -0.0000 * (safeZoneH*1.03)"; w = "0.3200 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
        };
        class Lbl7 : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + 0.0500 * (safeZoneH*1.03)"; w = "0.3300 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
            sizeEx = "0.021 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; text = "PERMIS DE CONDUIRE / ВОДИТЕЛЬСКИЕ ПРАВА";
        };
        class Fld7 : DOC_RscCombo
        {
            sizeEx = "0.03 * (safeZoneH*1.03)";
            idc = 74220;
            x = "(safeZoneX + safeZoneW/2) + 0.0150 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + 0.0500 * (safeZoneH*1.03)"; w = "0.3200 * (safeZoneH*1.03)"; h = "0.0400 * (safeZoneH*1.03)";
        };
        class Decl : DOC_RscStructuredText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + 0.1150 * (safeZoneH*1.03)"; w = "0.6400 * (safeZoneH*1.03)"; h = "0.0700 * (safeZoneH*1.03)";
            size = "0.021 * (safeZoneH*1.03)"; text = "Je soussigné(e) certifie sur l'honneur l'exactitude des informations ci-dessus. <t color='#7a1a1a'>Le nom et le prénom correspondent à mon profil.</t>";
        };
        class SigLbl : DOC_RscText
        {
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + 0.1870 * (safeZoneH*1.03)"; w = "0.6400 * (safeZoneH*1.03)"; h = "0.0300 * (safeZoneH*1.03)";
            sizeEx = "0.021 * (safeZoneH*1.03)"; colorText[] = {0.15,0.15,0.15,1}; text = "SIGNATURE / ПОДПИСЬ  (saisir votre nom et prenom complets)";
        };
        class Sig : DOC_RscEdit
        {
            idc = 74221;
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + 0.2150 * (safeZoneH*1.03)"; w = "0.6550 * (safeZoneH*1.03)"; h = "0.0480 * (safeZoneH*1.03)";
            sizeEx = "0.04 * (safeZoneH*1.03)"; style = 0;
        };
        class Err : DOC_RscText
        {
            idc = 74222;
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + 0.2700 * (safeZoneH*1.03)"; w = "0.6550 * (safeZoneH*1.03)"; h = "0.0350 * (safeZoneH*1.03)";
            sizeEx = "0.026 * (safeZoneH*1.03)"; colorText[] = {0.7,0.1,0.1,1}; text = "";
        };
        class Sign : DOC_RscButton
        {
            sizeEx = "0.032 * (safeZoneH*1.03)";
            idc = 74223;
            x = "(safeZoneX + safeZoneW/2) + -0.3200 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + 0.3200 * (safeZoneH*1.03)"; w = "0.4000 * (safeZoneH*1.03)"; h = "0.0600 * (safeZoneH*1.03)";
            text = "SIGNER ET DEPOSER LA DEMANDE"; action = "[] spawn DOC_fnc_formSubmit;";
        };
        class Cancel : DOC_RscButton
        {
            sizeEx = "0.032 * (safeZoneH*1.03)";
            idc = 74224;
            x = "(safeZoneX + safeZoneW/2) + 0.1100 * (safeZoneH*1.03)"; y = "(safeZoneY + safeZoneH/2) + 0.3200 * (safeZoneH*1.03)"; w = "0.2250 * (safeZoneH*1.03)"; h = "0.0600 * (safeZoneH*1.03)";
            text = "RETOUR"; colorBackground[] = {0.4,0.4,0.4,1}; colorBackgroundActive[] = {0.55,0.55,0.55,1}; action = "closeDialog 2;";
        };
    };
};
