class A3A_EndMissionTimer: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_EndMissionTimer"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_endMissionTimer.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_ending";

	function = "a3a_fnc_module_endMissionTimer";
	functionPriority = 1;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		// Module specific arguments
		class Time
		{
			displayName = "$STR_A3A_Modules_EndMissionTimer_1_Name"; // Argument label
			description = "$STR_A3A_Modules_EndMissionTimer_1_Desc"; // Tooltip description
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
			class values
			{
				class 1min {name = "1 minute (For TESTS)"; value = 60; };
				class 10min {name = "10 minutes"; value = 600; };
				class 20min {name = "20 minutes"; value = 1200; };
				class 30min {name = "30 minutes"; value = 1800; };
				class 40min {name = "40 minutes"; value = 2400; };
				class 50min {name = "50 minutes"; value = 3000; };
				class 60min {name = "1 hour"; value = 3600; default = 1; };
				class 70min {name = "1 hour 10 minutes"; value = 4200; };
				class 80min {name = "1 hour 20 minutes"; value = 4800; };
				class 90min {name = "1 hour 30 minutes"; value = 5400; };
				class 100min {name = "1 hour 40 minutes"; value = 6000; };
				class 110min {name = "1 hour 50 minutes"; value = 6600; };
				class 120min {name = "2 hours"; value = 7200; };
				class 130min {name = "2 hours 10 minutes"; value = 7800; };
				class 140min {name = "2 hour 20 minutes"; value = 8400; };
				class 150min {name = "2 hour 30 minutes"; value = 9000; };
				class 160min {name = "2 hour 40 minutes"; value = 9600; };
				class 170min {name = "2 hour 50 minutes"; value = 10200; };
				class 180min {name = "3 hours"; value = 10800; };
			};
		};
		class Side
		{
			displayName = "$STR_A3A_Modules_EndMissionTimer_2_Name";
			description = "$STR_A3A_Modules_EndMissionTimer_2_Desc";
			//defaultValue = "Tsar Bomba"; // Default text filled in the input box
			// When no 'values' are defined, input box is displayed instead of listbox
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
			class values
			{
				class value1 {name = "WEST"; value = 0; default = 1; };
				class value2 {name = "EAST"; value = 1; };
				class value3 {name = "RESISTANCE"; value = 2; };
			};
		};
		class Message
		{
			displayName = "$STR_A3A_Modules_EndMissionTimer_3_Name";
			description = "$STR_A3A_Modules_EndMissionTimer_3_Desc";
			defaultValue = "Time is up!"; // Default text filled in the input box
			// When no 'values' are defined, input box is displayed instead of listbox
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		#include "Diary.hpp"
		#include "Order.hpp"
	};
};