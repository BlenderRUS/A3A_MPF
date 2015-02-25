class A3A_LockVehiclesTimer: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_LockVehiclesTimer"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_LockVehiclesTimer.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_settings";

	function = "a3a_fnc_module_LockVehiclesTimer";
	functionPriority = 9;
	isGlobal = 0;
	class Arguments: ArgumentsBaseUnits
	{
		class Time
		{
			displayName = "$STR_A3A_Modules_LockVehiclesTimer_1_name";
			description = "$STR_A3A_Modules_LockVehiclesTimer_1_desc";
			typeName = "NUMBER";
			defaultValue = 0;
		};
		class Side
		{
			displayName = "$STR_A3A_Modules_LockVehiclesTimer_2_name";
			description = "$STR_A3A_Modules_LockVehiclesTimer_2_desc";
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
		class Message
		{
			displayName = "$STR_A3A_Modules_LockVehiclesTimer_3_name";
			description = "$STR_A3A_Modules_LockVehiclesTimer_3_desc";
			defaultValue = "Mortars are unlocked!"; // Default text filled in the input box
			typeName = "STRING";
		};
		#include "Diary.hpp"
		#include "Order.hpp"
	};
};