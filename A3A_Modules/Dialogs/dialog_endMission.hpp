/* #Gagydi
$[
	1.063,
	["A3A_EndMission",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,1,0],
	[1200,"background",[2,"RESOURCES\back_endMission.paa",["0 * GUI_GRID_W + GUI_GRID_X","-5.5 * GUI_GRID_H + GUI_GRID_Y","40 * GUI_GRID_W","36 * GUI_GRID_H"],[-1,-1,-1,-1],[0,0,0,0.3],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"uavpic",[2,"",["5.5 * GUI_GRID_W + GUI_GRID_X","3 * GUI_GRID_H + GUI_GRID_Y","29 * GUI_GRID_W","19.5 * GUI_GRID_H"],[-1,-1,-1,-1],[0,0,0,1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"text",[2,"",["5.5 * GUI_GRID_W + GUI_GRID_X","3 * GUI_GRID_H + GUI_GRID_Y","29 * GUI_GRID_W","19.5 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

#define IDC_A3A_ENDMISSION_TEXT		10473
#define IDC_A3A_ENDMISSION_BACKGROUND	10573
#define IDC_A3A_ENDMISSION_UAVPIC	10574

class A3A_EndMission
{
	#define GUI_GRID_X	(0)
	#define GUI_GRID_Y	(0)
	#define GUI_GRID_W	(0.025)
	#define GUI_GRID_H	(0.04)
	#define GUI_GRID_WAbs	(1)
	#define GUI_GRID_HAbs	(1)

	idd = -1;
	movingEnable = 1;
	duration = 1e+011;
	name = "A3A_EndMission";
	onLoad = "uiNamespace setVariable ['A3A_EndMission', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['A3A_EndMission', nil]";
	controls[]=
	{
		background,
		uavpic,
		text
	};
	class background: RscPicture
	{
		idc = IDC_A3A_ENDMISSION_BACKGROUND;
		text = "\A3A_Modules\Resources\back_endMission.paa";
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = -5.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 36 * GUI_GRID_H;
		colorBackground[] = {0,0,0,0.3};
	};
	class uavpic: RscPicture
	{
		idc = IDC_A3A_ENDMISSION_UAVPIC;
		x = 5.5 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 29 * GUI_GRID_W;
		h = 19.5 * GUI_GRID_H;
		colorBackground[] = {0,0,0,1};
	};
	class text: RscStructuredText
	{
		idc = IDC_A3A_ENDMISSION_TEXT;
		x = 5.5 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 29 * GUI_GRID_W;
		h = 19.5 * GUI_GRID_H;
	};
};