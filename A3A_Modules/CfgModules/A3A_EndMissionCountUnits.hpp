class A3A_EndMissionCountUnits: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_EndMissionCountUnits"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_endMissionCountUnits.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_ending";

	function = "a3a_fnc_module_EndMissionCountUnits";
	functionPriority = 3;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class MarkerName
		{
			displayName = "$STR_A3A_Modules_EndMissionCountUnits_1_Name";
			description = "$STR_A3A_Modules_EndMissionCountUnits_1_Desc";
			defaultValue = "marker_1"; // Default text filled in the input box
			typeName = "STRING";
		};
		class Side
		{
			displayName = "$STR_A3A_Modules_EndMissionCountUnits_2_Name";
			description = "$STR_A3A_Modules_EndMissionCountUnits_2_Desc";
			typeName = "NUMBER";
			class values
			{
				class value1 {name = "WEST"; value = 0; default = 1; };
				class value2 {name = "EAST"; value = 1; };
				class value3 {name = "RESISTANCE"; value = 2; };
			};
		};
		class MinMan
		{
			displayName = "$STR_A3A_Modules_EndMissionCountUnits_3_Name";
			description = "$STR_A3A_Modules_EndMissionCountUnits_3_Desc";
			typeName = "NUMBER";
			defaultValue = 10;
		};
		class Message
		{
			displayName = "$STR_A3A_Modules_EndMissionCountUnits_4_Name";
			description = "$STR_A3A_Modules_EndMissionCountUnits_4_Desc";
			defaultValue = "No base defenders left"; // Default text filled in the input box
			typeName = "STRING";
		};
		#include "Diary.hpp"
		#include "Order.hpp"
	};
};