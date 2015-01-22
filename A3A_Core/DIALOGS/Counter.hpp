/* #Vadyhe
$[
	1.063,
	["a3a_counter",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"img_background",[1,"\A3A_Core\RESOURCES\a3a_counterBack.paa",["0.410606 * safezoneW + safezoneX","0.0158411 * safezoneH + safezoneY","0.171911 * safezoneW","0.0550181 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"text_timer",[1,"WAITING",["0.444989 * safezoneW + safezoneX","0.0268447 * safezoneH + safezoneY","0.103146 * safezoneW","0.0330108 * safezoneH"],[1,1,1,1],[0,0,0,0],[-1,-1,-1,-1],"","-1"],["sizeEx = 0.065;","style = |0x02|;","shadow = 0;"]],
	[1201,"img_side_1",[1,"\A3A_Core\RESOURCES\a3a_cb_false.paa",["0.0119002 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.0174635 * safezoneW","0.0237857 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"img_side_2",[1,"\A3A_Core\RESOURCES\a3a_cb_false.paa",["0.0119002 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0174635 * safezoneW","0.0237857 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"text_leaders_1",[1,"",["0.0119002 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.178741 * safezoneW","0.286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"text_leaders_2",[1,"",["0.0119002 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.178741 * safezoneW","0.286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"text_side_1",[1,"",["0.0325242 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.144368 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"","-1"],[]],
	[1103,"text_side_2",[1,"",["0.0325242 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.144368 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"","-1"],[]]
]
*/

/*
		sizeEx = 0.065;
		colorBackground[] = {0,0,0,0};
		colorText[] = {1,1,1,1};
		fixedWidth = 0;
		style = "0x02";
		shadow = 0;
*/


class A3A_Counter
{
	idd = -1;
	movingEnable = 0;
	duration = 1e+011;
	name = "A3A_Counter";
	onLoad = "uiNamespace setVariable ['A3A_Counter', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['A3A_Counter', nil]";
	controlsBackground[] = { img_background };
	objects[] = {};
	controls[]=
	{
		text_timer,
		img_side_1,
		img_side_2,
		text_leaders_1,
		text_leaders_2,
		text_side_1,
		text_side_2
	};
	class img_background: RscPicture
	{
		idc = 1200;
		text = "\A3A_Core\RESOURCES\a3a_counterBack.paa";
		x = 0.410606 * safezoneW + safezoneX;
		y = 0.0158411 * safezoneH + safezoneY;
		w = 0.171911 * safezoneW;
		h = 0.0550181 * safezoneH;
	};
	class text_timer: RscText
	{
		sizeEx = 0.065;
		style = "0x02";
		shadow = 0;

		idc = 1000;
		text = "WAITING";
		x = 0.444989 * safezoneW + safezoneX;
		y = 0.0268447 * safezoneH + safezoneY;
		w = 0.103146 * safezoneW;
		h = 0.0330108 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
	};
	class img_side_1: RscPicture
	{
		idc = 1201;
		text = "\A3A_Core\RESOURCES\a3a_cb_false.paa";
		x = 0.0119002 * safezoneW + safezoneX;
		y = 0.291 * safezoneH + safezoneY;
		w = 0.0174635 * safezoneW;
		h = 0.0237857 * safezoneH;
	};
	class img_side_2: RscPicture
	{
		idc = 1202;
		text = "\A3A_Core\RESOURCES\a3a_cb_false.paa";
		x = 0.0119002 * safezoneW + safezoneX;
		y = 0.621 * safezoneH + safezoneY;
		w = 0.0174635 * safezoneW;
		h = 0.0237857 * safezoneH;
	};
	class text_leaders_1: RscStructuredText
	{
		idc = 1100;
		x = 0.0119002 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.178741 * safezoneW;
		h = 0.286 * safezoneH;
	};
	class text_leaders_2: RscStructuredText
	{
		idc = 1101;
		x = 0.0119002 * safezoneW + safezoneX;
		y = 0.654 * safezoneH + safezoneY;
		w = 0.178741 * safezoneW;
		h = 0.286 * safezoneH;
	};
	class text_side_1: RscStructuredText
	{
		idc = 1102;
		x = 0.0325242 * safezoneW + safezoneX;
		y = 0.291 * safezoneH + safezoneY;
		w = 0.144368 * safezoneW;
		h = 0.022 * safezoneH;
		colorBackground[] = {0,0,0,0};
	};
	class text_side_2: RscStructuredText
	{
		idc = 1103;
		x = 0.0325242 * safezoneW + safezoneX;
		y = 0.621 * safezoneH + safezoneY;
		w = 0.144368 * safezoneW;
		h = 0.022 * safezoneH;
		colorBackground[] = {0,0,0,0};
	};
};