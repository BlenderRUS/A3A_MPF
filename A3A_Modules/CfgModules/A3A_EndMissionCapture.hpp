class A3A_EndMissionCapture: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_EndMissionCapture"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_endMissionCapture.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_ending";

	function = "a3a_fnc_module_EndMissionCapture";
	functionPriority = 2;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class CapTime
		{
			displayName = "$STR_A3A_Modules_EndMissionCapture_1_Name";
			description = "$STR_A3A_Modules_EndMissionCapture_1_Desc";
			typeName = "NUMBER";
			defaultValue = 10;
		};
		class HoldTime
		{
			displayName = "$STR_A3A_Modules_EndMissionCapture_2_Name";
			description = "$STR_A3A_Modules_EndMissionCapture_2_Desc";
			typeName = "NUMBER";
			defaultValue = 10;
		};
		class CaptureSide
		{
			displayName = "$STR_A3A_Modules_EndMissionCapture_6_Name";
			description = "$STR_A3A_Modules_EndMissionCapture_6_Desc";
			typeName = "NUMBER";
			class values
			{
				class value1 {name = "$STR_A3A_Modules_Every1"; value = 0; default = 1; };
				class value2 {name = "WEST"; value = 1; };
				class value3 {name = "EAST"; value = 2; };
				class value4 {name = "RESISTANCE"; value = 3; };
			};
		};
		class MarkerName
		{
			displayName = "$STR_A3A_Modules_EndMissionCapture_3_Name";
			description = "$STR_A3A_Modules_EndMissionCapture_3_Desc";
			defaultValue = "marker_1"; // Default text filled in the input box
			typeName = "STRING";
		};
		class AreaName
		{
			displayName = "$STR_A3A_Modules_EndMissionCapture_4_Name";
			description = "$STR_A3A_Modules_EndMissionCapture_4_Desc";
			defaultValue = "Oreokastro Castle"; // Default text filled in the input box
			typeName = "STRING";
		};
		class ChangeMarkerColor
		{
			displayName = "$STR_A3A_Modules_EndMissionCapture_5_Name";
			description = "$STR_A3A_Modules_EndMissionCapture_5_Desc";
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
			class values
			{
				class value1 {name = "$STR_A3A_Modules_Yes"; value = 1; default = 1; };
				class value2 {name = "$STR_A3A_Modules_No"; value = 0; };
			};
		};
		#include "Diary.hpp"
		#include "Order.hpp"
	};
};