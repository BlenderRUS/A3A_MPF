#include "BaseRsc.hpp"

class A3RU_RscButton2: A3RU_RscButton {
	style = 0;
	colorBackground[] = {0, 0, 0, 0.5};
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	sizeEx = 0.028;
	shadow = 0;
	colorFocused[] = {0.3254, 0.3254, 0.3254, 1};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
};

class A3RU_POPUP_UI
{
	idd = 1351;
	movingEnable = 1;
	duration = 1e+011;
	name = "A3RUPOPUP_name";
	onLoad = "uiNamespace setVariable ['A3RU_POPUP_UI', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['A3RU_POPUP_UI', nil]";
	controlsBackground[] = {a3ru_popback};
	objects[] = {};
	controls[] = {
		a3ru_poptext,
		a3ru_popb1,
		a3ru_popb2,
		a3ru_popb3,
		a3ru_popb4,
		a3ru_popb5,
		a3ru_popb6,
		a3ru_popb7,
		a3ru_popb8,
		a3ru_popb9
	};
	class a3ru_popback: A3RU_IGUIBack
	{
		idc = 1700;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.532995 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
		colorBackground[] = {0.34, 0.5882, 0.2392, 0.8};
	};
	class a3ru_poptext: A3RU_RscText
	{
		idc = 1701;
		text = "Atrium Action Menu";
		font = "PuristaMedium";
		sizeEx = 0.03;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.532995 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
	};
	class a3ru_popb1: A3RU_RscButton2
	{
		idc = 1702;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.555591 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
	};
	class a3ru_popb2: A3RU_RscButton2
	{
		idc = 1703;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.578188 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
	};
	class a3ru_popb3: A3RU_RscButton2
	{
		idc = 1704;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.600784 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
	};
	class a3ru_popb4: A3RU_RscButton2
	{
		idc = 1705;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.623381 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
	};
	class a3ru_popb5: A3RU_RscButton2
	{
		idc = 1706;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.645977 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
	};
	class a3ru_popb6: A3RU_RscButton2
	{
		idc = 1707;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.668574 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
	};
	class a3ru_popb7: A3RU_RscButton2
	{
		idc = 1708;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.69117 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
	};
	class a3ru_popb8: A3RU_RscButton2
	{
		idc = 1709;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.7137375 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0230965 * safezoneH;
	};
	class a3ru_popb9: A3RU_RscButton2
	{
		idc = 1710;
		x = 0.51375 * safezoneW + safezoneX;
		y = 0.736363 * safezoneH + safezoneY;
		w = 0.130625 * safezoneW;
		h = 0.0225965 * safezoneH;
	};
};

class A3RU_WEAPON_HUD
{
	idd = 1350;
	movingEnable = 1;
	duration = 1e+011;
	name = "A3RUWEAPHUD_name";
	onLoad = "uiNamespace setVariable ['A3RU_WEAPON_HUD', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['A3RU_WEAPON_HUD', nil]";
	controlsBackground[] = {a3ru_weap_back};
	objects[] = {};
	controls[]=
	{
		a3ru_weap_primaryImage,
		a3ru_weap_PrimaryText,
		a3ru_weap_primaryBack,
		a3ru_weap_primaryNext,
		a3ru_weap_primaryDesc,
		a3ru_weap_mod1Image,
		a3ru_weap_mod2Image,
		a3ru_weap_mod3Image,
		a3ru_weap_mod1Back,
		a3ru_weap_mod2Back,
		a3ru_weap_mod3Back,
		a3ru_weap_mod1Next,
		a3ru_weap_mod2Next,
		a3ru_weap_mod3Next,
		a3ru_weap_secondaryImage,
		a3ru_weap_secondaryBack,
		a3ru_weap_secondaryNext,
		a3ru_weap_secondaryDesc,
		a3ru_weap_sideImage,
		a3ru_weap_sideBack,
		a3ru_weap_sideNext,
		a3ru_weap_sideDesc,
		a3ru_weap_modText,
		a3ru_weap_backpackText,
		a3ru_weap_backpackImage,
		a3ru_weap_backpackNext,
		a3ru_weap_backpackBack,
		a3ru_weap_backpackDesc,
		a3ru_weap_secondaryText,
		a3ru_weap_sideText,
		a3ru_weap_equip,
		a3ru_weap_note,
		a3ru_weap_logo
	};

	class a3ru_weap_back: A3RU_IGUIBack
	{
		idc = 2200;
		x = 0.335625 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.37 * safezoneW;
		h = 0.495 * safezoneH;
	};
	class a3ru_weap_primaryImage: A3RU_RscPicture
	{
		idc = 1200;
		text = "";
		style = "0x30 + 0x800";
		x = 0.39 * safezoneW + safezoneX;
		y = 0.269 * safezoneH + safezoneY;
		w = 0.11 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class a3ru_weap_PrimaryText: A3RU_RscText
	{
		idc = 1000;
		text = "$STR_A3RU_weap_primary"; //--- ToDo: Localize;
		x = 0.40375 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_primaryBack: A3RU_RscButton
	{
		idc = 1600;
		text = "<<"; //--- ToDo: Localize;
		x = 0.3625 * safezoneW + safezoneX;
		y = 0.302 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_primaryNext: A3RU_RscButton
	{
		idc = 1601;
		text = ">>"; //--- ToDo: Localize;
		x = 0.506875 * safezoneW + safezoneX;
		y = 0.302 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_primaryDesc: A3RU_RscEdit
	{
		idc = 1400;
		text = ""; //--- ToDo: Localize;
		style = "0x02";
		x = 0.3625 * safezoneW + safezoneX;
		y = 0.368 * safezoneH + safezoneY;
		w = 0.165 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_mod1Image: A3RU_RscPicture
	{
		idc = 1201;
		text = "";
		style = "0x30 + 0x800";
		x = 0.603125 * safezoneW + safezoneX;
		y = 0.269 * safezoneH + safezoneY;
		w = 0.0275 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_mod2Image: A3RU_RscPicture
	{
		idc = 1202;
		text = "";
		style = "0x30 + 0x800";
		x = 0.603125 * safezoneW + safezoneX;
		y = 0.302 * safezoneH + safezoneY;
		w = 0.0275 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_mod3Image: A3RU_RscPicture
	{
		idc = 1203;
		text = "";
		style = "0x30 + 0x800";
		x = 0.603125 * safezoneW + safezoneX;
		y = 0.335 * safezoneH + safezoneY;
		w = 0.0275 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_mod1Back: A3RU_RscButton
	{
		idc = 1602;
		text = "<<"; //--- ToDo: Localize;
		x = 0.575625 * safezoneW + safezoneX;
		y = 0.269 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_mod2Back: A3RU_RscButton
	{
		idc = 1603;
		text = "<<"; //--- ToDo: Localize;
		x = 0.575625 * safezoneW + safezoneX;
		y = 0.302 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_mod3Back: A3RU_RscButton
	{
		idc = 1604;
		text = "<<"; //--- ToDo: Localize;
		x = 0.575625 * safezoneW + safezoneX;
		y = 0.335 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_mod1Next: A3RU_RscButton
	{
		idc = 1605;
		text = ">>"; //--- ToDo: Localize;
		x = 0.6375 * safezoneW + safezoneX;
		y = 0.269 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_mod2Next: A3RU_RscButton
	{
		idc = 1606;
		text = ">>"; //--- ToDo: Localize;
		x = 0.6375 * safezoneW + safezoneX;
		y = 0.302 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_mod3Next: A3RU_RscButton
	{
		idc = 1607;
		text = ">>"; //--- ToDo: Localize;
		x = 0.6375 * safezoneW + safezoneX;
		y = 0.335 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_secondaryImage: A3RU_RscPicture
	{
		idc = 1204;
		text = "";
		style = "0x30 + 0x800";
		x = 0.39 * safezoneW + safezoneX;
		y = 0.423 * safezoneH + safezoneY;
		w = 0.11 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class a3ru_weap_secondaryBack: A3RU_RscButton
	{
		idc = 1608;
		text = "<<"; //--- ToDo: Localize;
		x = 0.3625 * safezoneW + safezoneX;
		y = 0.456 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_secondaryNext: A3RU_RscButton
	{
		idc = 1609;
		text = ">>"; //--- ToDo: Localize;
		x = 0.506875 * safezoneW + safezoneX;
		y = 0.456 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_secondaryDesc: A3RU_RscEdit
	{
		idc = 1401;
		text = ""; //--- ToDo: Localize;
		style = "0x02";
		x = 0.3625 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.165 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_sideImage: A3RU_RscPicture
	{
		idc = 1205;
		text = "";
		style = "0x30 + 0x800";
		x = 0.410625 * safezoneW + safezoneX;
		y = 0.577 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.066 * safezoneH;
	};
	class a3ru_weap_sideBack: A3RU_RscButton
	{
		idc = 1610;
		text = "<<"; //--- ToDo: Localize;
		x = 0.383125 * safezoneW + safezoneX;
		y = 0.599 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_sideNext: A3RU_RscButton
	{
		idc = 1611;
		text = ">>"; //--- ToDo: Localize;
		x = 0.48625 * safezoneW + safezoneX;
		y = 0.599 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_sideDesc: A3RU_RscEdit
	{
		idc = 1402;
		text = ""; //--- ToDo: Localize;
		style = "0x02";
		x = 0.3625 * safezoneW + safezoneX;
		y = 0.654 * safezoneH + safezoneY;
		w = 0.165 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_modText: A3RU_RscText
	{
		idc = 1001;
		text = "$STR_A3RU_weap_mods"; //--- ToDo: Localize;
		x = 0.575625 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.089375 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_backpackText: A3RU_RscText
	{
		idc = 1002;
		text = "$STR_A3RU_weap_backpack"; //--- ToDo: Localize;
		x = 0.575625 * safezoneW + safezoneX;
		y = 0.386 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_backpackImage: A3RU_RscPicture
	{
		idc = 1206;
		text = "";
		style = "0x30 + 0x800";
		x = 0.5825 * safezoneW + safezoneX;
		y = 0.408 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class a3ru_weap_backpackNext: A3RU_RscButton
	{
		idc = 1612;
		text = ">>"; //--- ToDo: Localize;
		x = 0.658125 * safezoneW + safezoneX;
		y = 0.441 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_backpackBack: A3RU_RscButton
	{
		idc = 1613;
		text = "<<"; //--- ToDo: Localize;
		x = 0.555 * safezoneW + safezoneX;
		y = 0.441 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_backpackDesc: A3RU_RscEdit
	{
		idc = 1403;
		text = ""; //--- ToDo: Localize;
		style = "0x02";
		x = 0.5355 * safezoneW + safezoneX;
		y = 0.502 * safezoneH + safezoneY;
		w = 0.165 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_secondaryText: A3RU_RscText
	{
		idc = 1003;
		text = "$STR_A3RU_weap_secondary"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.401 * safezoneH + safezoneY;
		w = 0.09625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_sideText: A3RU_RscText
	{
		idc = 1004;
		text = "$STR_A3RU_weap_side"; //--- ToDo: Localize;
		x = 0.424375 * safezoneW + safezoneX;
		y = 0.555 * safezoneH + safezoneY;
		w = 0.04205 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_equip: A3RU_RscButton
	{
		idc = 1614;
		text = "$STR_A3RU_weap_equip"; //--- ToDo: Localize;
		x = 0.451875 * safezoneW + safezoneX;
		y = 0.687 * safezoneH + safezoneY;
		w = 0.144375 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class a3ru_weap_note: A3RU_RscText
	{
		idc = 1005;
		text = "$STR_A3RU_weap_note"; //--- ToDo: Localize;
		colorText[] = {1, 1, 0, 1};
		x = 0.415375 * safezoneW + safezoneX;
		y = 0.72 * safezoneH + safezoneY;
		w = 0.213125 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class a3ru_weap_logo: A3RU_RscPicture
	{
		idc = 1207;
		text = "A3A_Core\RESOURCES\atrium_logo.paa";
		style = "0x30 + 0x800";
		x = 0.561875 * safezoneW + safezoneX;
		y = 0.544 * safezoneH + safezoneY;
		w = 0.11 * safezoneW;
		h = 0.121 * safezoneH;
	};
};