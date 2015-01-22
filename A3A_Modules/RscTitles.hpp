class RscTitles {
	class RscPicture
	{
		access = 0;
		type = 0;
		idc = -1;
		style = 48;
		colorBackground[] = 
		{
			0,
			0,
			0,
			0
		};
		colorText[] = 
		{
			1,
			1,
			1,
			1
		};
		font = "TahomaB";
		sizeEx = 0;
		lineSpacing = 0;
		text = "";
		fixedWidth = 0;
		shadow = 0;
		x = 0;
		y = 0;
		w = 0.2;
		h = 0.15;
		tooltipColorText[] = 
		{
			1,
			1,
			1,
			1
		};
		tooltipColorBox[] = 
		{
			1,
			1,
			1,
			1
		};
		tooltipColorShade[] = 
		{
			0,
			0,
			0,
			0.65
		};
	};

	class RscText
	{
		access = 0;
		type = 0;
		idc = -1;
		colorBackground[] = 
		{
			0,
			0,
			0,
			0
		};
		colorText[] = 
		{
			1,
			1,
			1,
			1
		};
		text = "";
		fixedWidth = 0;
		x = 0;
		y = 0;
		h = 0.037;
		w = 0.3;
		style = 0;
		shadow = 1;
		colorShadow[] = 
		{
			0,
			0,
			0,
			0.5
		};
		font = "PuristaMedium";
		SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		linespacing = 1;
		tooltipColorText[] = 
		{
			1,
			1,
			1,
			1
		};
		tooltipColorBox[] = 
		{
			1,
			1,
			1,
			1
		};
		tooltipColorShade[] = 
		{
			0,
			0,
			0,
			0.65
		};
	};
	class ATRIUM_CAP_PROGRESS_UI
	{
		idd = -1;
		movingEnable = 0;
		duration = 1e+011;
		name = "ATRIUM_CAP_PROGRESS_UI";
		onLoad = "uiNamespace setVariable ['ATRIUM_CAP_PROGRESS_UI', _this select 0];";
		onUnLoad = "uiNamespace setVariable ['ATRIUM_CAP_PROGRESS_UI', nil]";
		controlsBackground[] = {back};
		objects[] = {};
		controls[]=
		{
			progress,
			text
		};
		class back: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0.2,0.2,0.2,1)";
			x = 0.376282 * safezoneW + safezoneX;
			y = 0.0599521 * safezoneH + safezoneY;
			w = 0.247436 * safezoneW;
			h = 0.0220024 * safezoneH;
		};
		class progress: RscPicture
		{
			idc = 1201;
			text = "\A3A_Modules\resources\neut_cap.paa";
			x = 0.378756 * safezoneW + safezoneX;
			y = 0.0645726 * safezoneH + safezoneY;
			w = 0.243035 * safezoneW;
			h = 0.0131283 * safezoneH;
		};
		class text: RscText
		{
			idc = 1000;
			style = "0x02";
			x = 0.376282 * safezoneW + safezoneX;
			y = 0.0819545 * safezoneH + safezoneY;
			w = 0.247436 * safezoneW;
			h = 0.0220024 * safezoneH;
		};
	};
};