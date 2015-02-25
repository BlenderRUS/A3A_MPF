class A3A_EndMissionVipInZone: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_EndMissionVipInZone"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_endMissionVipInZone.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_ending";

	function = "A3A_fnc_Module_EndMissionVipInZone";
	functionPriority = 10;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class MarkerName
		{
			displayName = "$STR_A3A_Modules_EndMissionVipInZone_1_Name";
			description = "$STR_A3A_Modules_EndMissionVipInZone_1_Desc";
			defaultValue = "marker_1"; // Default text filled in the input box
			typeName = "STRING";
		};
		class MinUnits
		{
			displayName = "$STR_A3A_Modules_EndMissionVipInZone_2_Name";
			description = "$STR_A3A_Modules_EndMissionVipInZone_2_Desc";
			typeName = "NUMBER";
			defaultValue = 1;
		};
		class Side
		{
			displayName = "$STR_A3A_Modules_EndMissionVipInZone_3_Name";
			description = "$STR_A3A_Modules_EndMissionVipInZone_3_Desc";
			typeName = "NUMBER";
			class values
			{
				class value1 {name = "$STR_A3A_Modules_NoOne"; value = -2; };
				class value2 {name = "$STR_A3A_Modules_Everyone"; value = -1; default = 1; };
				class value3 {name = "WEST"; value = 0; };
				class value4 {name = "EAST"; value = 1; };
				class value5 {name = "RESISTANCE"; value = 2; };
			};
		};
		class WinSide
		{
			displayName = "$STR_A3A_Modules_EndMissionVipInZone_4_Name";
			description = "$STR_A3A_Modules_EndMissionVipInZone_4_Desc";
			typeName = "NUMBER";
			class values
			{
				class value3 {name = "WEST"; value = 0; default = 1; };
				class value4 {name = "EAST"; value = 1; };
				class value5 {name = "RESISTANCE"; value = 2; };
			};
		};
		#include "Diary.hpp"
		#include "Order.hpp"
	};
};