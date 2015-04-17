class A3A_Settings: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_Settings"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_settings.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_settings";

	function = "A3A_fnc_Modules_Dummy";
	functionPriority = 1;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class BFSide
		{
			displayName = "$STR_A3A_Modules_Settings_1_Name";
			description = "$STR_A3A_Modules_Settings_1_Desc";
			typeName = "STRING";
			class values
			{
				class value1 {name = "WEST"; value = "WEST"; default = 1; };
				class value2 {name = "EAST"; value = "EAST"; };
				class value3 {name = "RESISTANCE"; value = "RESISTANCE"; };
			};
		};
		class OFSide
		{
			displayName = "$STR_A3A_Modules_Settings_2_Name";
			description = "$STR_A3A_Modules_Settings_2_Desc";
			typeName = "STRING";
			class values
			{
				class value1 {name = "WEST"; value = "WEST"; };
				class value2 {name = "EAST"; value = "EAST"; default = 1; };
				class value3 {name = "RESISTANCE"; value = "RESISTANCE"; };
			};
		};
		class PrepareZoneSize
		{
			displayName = "$STR_A3A_Modules_Settings_3_Name";
			description = "$STR_A3A_Modules_Settings_3_Desc";
			typeName = "NUMBER";
			defaultValue = 150;
		};
		class UAVIntro
		{
			displayName = "$STR_A3A_Modules_Settings_4_Name";
			description = "$STR_A3A_Modules_Settings_4_Desc";
			typeName = "NUMBER";
			class values {
				class value0 {name = "No"; value = 0; };
				class value1 {name = "Yes"; value = 1; default = 1; };
			};
		};
		class FireteamHUD
		{
			displayName = "$STR_A3A_Modules_Settings_5_Name";
			description = "$STR_A3A_Modules_Settings_5_Desc";
			typeName = "NUMBER";
			class values {
				class value0 {name = "No"; value = 0; };
				class value1 {name = "Yes"; value = 1; default = 1; };
			};
		};
		class ViewDistance
		{
			displayName = "$STR_A3A_Modules_Settings_6_Name";
			description = "$STR_A3A_Modules_Settings_6_Desc";
			typeName = "NUMBER";
			defaultValue = 3500;
		};
		class NoClientViewDistance
		{
			displayName = "$STR_A3A_Modules_Settings_7_Name";
			description = "$STR_A3A_Modules_Settings_7_Desc";
			typeName = "NUMBER";
			class values {
				class value0 {name = "No"; value = 0; default = 1; };
				class value1 {name = "Yes"; value = 1; };
			};
		};
		class DaytimeNVG
		{
			displayName = "$STR_A3A_Modules_Settings_8_Name";
			description = "$STR_A3A_Modules_Settings_8_Desc";
			typeName = "NUMBER";
			class values {
				class value0 {name = "No"; value = 0; default = 1; };
				class value1 {name = "Yes"; value = 1; };
			};
		};
		class EquipmentDialog
		{
			displayName = "$STR_A3A_Modules_Settings_9_Name";
			description = "$STR_A3A_Modules_Settings_9_Desc";
			typeName = "NUMBER";
			class values {
				class value0 {name = "No"; value = 0; };
				class value1 {name = "Yes"; value = 1; default = 1; };
			};
		};
		#include "Diary.hpp"
	};
};