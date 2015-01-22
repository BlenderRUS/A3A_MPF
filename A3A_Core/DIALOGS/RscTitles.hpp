class A3RU_DOGTAG_UI
{
	idd = 1354;
	movingEnable = 0;
	duration = 7;
	name = "A3RU_DogTag";
	onLoad = "uiNamespace setVariable ['A3RU_DOGTAG_UI', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['A3RU_DOGTAG_UI', nil]";
	controlsBackground[] = {dogTagBackground};
	objects[] = {};
	controls[] = {dogTagText};
	class dogTagBackground: A3RU_RscPicture
	{
		idc = 1200;
		text = "\A3A_Core\RESOURCES\a3a_dogTag.paa";
		x = 0.67875 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.158125 * safezoneW;
		h = 0.099 * safezoneH;
	};
	class dogTagText: A3RU_RscText
	{
		idc = 1000;
		text = ""; //--- ToDo: Localize;
		style = "0x00";
		colorText[] = {0.772,0.772,0.772,1};
		x = 0.713125 * safezoneW + safezoneX;
		y = 0.17 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.055 * safezoneH;
		sizeEx = 0.035;
		shadow = 1;
	};
};

class A3RU_PROGRESS_UI
{
	class A3RU_RscPicture2: A3RU_RscPicture {
		text = "\A3A_Core\RESOURCES\prog_block.jpg";
	};
	idd = 1352;
	movingEnable = 0;
	duration = 5;
	name = "A3RUPROGRESS_name";
	onLoad = "uiNamespace setVariable ['A3RU_PROGRESS_UI', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['A3RU_PROGRESS_UI', nil]";
	controlsBackground[] = {a3ru_pb_back};
	objects[] = {};
	controls[] = {
		a3ru_pb_1,
		a3ru_pb_2,
		a3ru_pb_3,
		a3ru_pb_4,
		a3ru_pb_5,
		a3ru_pb_6,
		a3ru_pb_7,
		a3ru_pb_8,
		a3ru_pb_9,
		a3ru_pb_10,
		a3ru_pb_text
	};
	class a3ru_pb_back: A3RU_RscPicture
	{
		idc = 1800;
		text = "A3A_Core\RESOURCES\prog_back.jpg";
		x = 0.393875 * safezoneW + safezoneX;
		y = 0.055044 * safezoneH + safezoneY;
		w = 0.21225 * safezoneW;
		h = 0.0219965 * safezoneH;
	};
	class a3ru_pb_1: A3RU_RscPicture2
	{
		idc = 1801;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_2: A3RU_RscPicture2
	{
		idc = 1802;
		x = 0.4175 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_3: A3RU_RscPicture2
	{
		idc = 1803;
		x = 0.438125 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_4: A3RU_RscPicture2
	{
		idc = 1804;
		x = 0.45875 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_5: A3RU_RscPicture2
	{
		idc = 1805;
		x = 0.479375 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_6: A3RU_RscPicture2
	{
		idc = 1806;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_7: A3RU_RscPicture2
	{
		idc = 1807;
		x = 0.520625 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_8: A3RU_RscPicture2
	{
		idc = 1808;
		x = 0.54125 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_9: A3RU_RscPicture2
	{
		idc = 1809;
		x = 0.561875 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_10: A3RU_RscPicture2
	{
		idc = 1810;
		x = 0.5825 * safezoneW + safezoneX;
		y = 0.059044 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.0139965 * safezoneH;
	};
	class a3ru_pb_text: A3RU_RscText
	{
		idc = 1811;
		text = ""; //--- ToDo: Localize;
		x = 0.393875 * safezoneW + safezoneX;
		//x = 0.451875 * safezoneW + safezoneX;
		//y = 0.242 * safezoneH + safezoneY;
		y = 0.055044 * safezoneH + safezoneY;
		//w = 0.09625 * safezoneW;
		w = 0.21225 * safezoneW;
		h = 0.022 * safezoneH;
	};
};