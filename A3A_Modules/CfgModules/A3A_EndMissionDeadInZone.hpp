class A3A_EndMissionDeadInZone: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_EndMissionDeadInZone"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_endMissionDeadInZone.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_ending";

	function = "a3a_fnc_module_EndMissionDeadInZone";
	functionPriority = 4;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class MarkerName
		{
			displayName = "$STR_A3A_Modules_EndMissionDeadInZone_1_Name";
			description = "$STR_A3A_Modules_EndMissionDeadInZone_1_Desc";
			defaultValue = "marker_1"; // Default text filled in the input box
			typeName = "STRING";
		};
		class MinUnits
		{
			displayName = "$STR_A3A_Modules_EndMissionDeadInZone_2_Name";
			description = "$STR_A3A_Modules_EndMissionDeadInZone_2_Desc";
			typeName = "NUMBER";
			defaultValue = 0;
		};
		class AreaName
		{
			displayName = "$STR_A3A_Modules_EndMissionDeadInZone_3_Name";
			description = "$STR_A3A_Modules_EndMissionDeadInZone_3_Desc";
			defaultValue = "My zone name"; // Default text filled in the input box
			typeName = "STRING";
		};
		#include "Diary.hpp"
		#include "Order.hpp"
	};
};