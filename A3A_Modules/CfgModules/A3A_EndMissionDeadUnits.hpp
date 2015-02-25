class A3A_EndMissionDeadUnits: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_EndMissionDeadUnits"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_endMissionDeadUnits.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_ending";

	function = "a3a_fnc_module_EndMissionDeadUnits";
	functionPriority = 11;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class MinUnits
		{
			displayName = "$STR_A3A_Modules_EndMissionDeadUnits_1_Name";
			description = "$STR_A3A_Modules_EndMissionDeadUnits_1_Desc";
			typeName = "NUMBER";
			defaultValue = 0;
		};
		class WinSide
		{
			displayName = "$STR_A3A_Modules_EndMissionDeadUnits_2_Name";
			description = "$STR_A3A_Modules_EndMissionDeadUnits_2_Desc";
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