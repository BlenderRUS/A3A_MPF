#define _ARMA_
class CfgPatches
{
	class A3A_Modules
	{
		units[] = {"A3A_EndMissionTimer", "A3A_EndMissionCapture", "A3A_EndMissionCountUnits", "A3A_EndMissionDeadInZone", "A3A_CombatLosses", "A3A_NoFreezeVehicles", "A3A_DontRemoveAI", "A3A_FreezeVehiclesTimer"};
		requiredAddons[] = { A3_Modules_F };
		requiredVersion = 1.38;
		version = "1.03";
		versionStr = "1.03";
		versionAr[] = {1,0,3};
		author[] = { "Blender" };
		authorUrl = "http://www.arma3.ru";
	};
};

class CfgFactionClasses
{
	class NO_CATEGORY;
	class a3a_ending: NO_CATEGORY
	{
		displayName = "$STR_A3A_Modules_Ending_Category";
	};
	class a3a_settings: NO_CATEGORY
	{
		displayName = "$STR_A3A_Modules_Settings_Category";
	};
};

class ArgumentsBaseUnits;
class CfgVehicles
{
	class Module_F;
	/// END MISSION ON TIMER END ///
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
			class Diary
  			{
				displayName = "$STR_A3A_Modules_WriteToDiary";
				description = "$STR_A3A_Modules_WriteToDiary_Desc";
				typeName = "BOOL";
			};
		};
	};
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
			class Diary
  			{
				displayName = "$STR_A3A_Modules_WriteToDiary";
				description = "$STR_A3A_Modules_WriteToDiary_Desc";
				typeName = "BOOL";
			};
		};
	};
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
			class Diary
  			{
				displayName = "$STR_A3A_Modules_WriteToDiary";
				description = "$STR_A3A_Modules_WriteToDiary_Desc";
				typeName = "BOOL";
			};
		};
	};
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
			class Diary
  			{
				displayName = "$STR_A3A_Modules_WriteToDiary";
				description = "$STR_A3A_Modules_WriteToDiary_Desc";
				typeName = "BOOL";
			};
		};
	};
	class A3A_CombatLosses: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "$STR_A3A_Modules_CombatLosses"; // Name displayed in the menu
		icon = "\A3A_Modules\data\icon_combatLosses.paa"; // Map icon. Delete this entry to use the default icon
		category = "a3a_ending";

		function = "a3a_fnc_module_CombatLosses";
		functionPriority = 5;
		isGlobal = 0;
		
		class Arguments: ArgumentsBaseUnits
		{
			class BFSideLoss
  			{
				displayName = "$STR_A3A_Modules_CombatLosses_1_Name";
				description = "$STR_A3A_Modules_CombatLosses_1_Desc";
				typeName = "NUMBER";
				defaultValue = 15;
			};
			class OFSideLoss
  			{
				displayName = "$STR_A3A_Modules_CombatLosses_2_Name";
				description = "$STR_A3A_Modules_CombatLosses_2_Desc";
				typeName = "NUMBER";
				defaultValue = 15;
			};
			class SideSupremacy
  			{
				displayName = "$STR_A3A_Modules_CombatLosses_3_Name";
				description = "$STR_A3A_Modules_CombatLosses_3_Desc";
				typeName = "NUMBER";
				defaultValue = 0;
			};
			class Diary
  			{
				displayName = "$STR_A3A_Modules_WriteToDiary";
				description = "$STR_A3A_Modules_WriteToDiary_Desc";
				typeName = "BOOL";
			};
		};
	};
	class A3A_DontRemoveAI: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "$STR_A3A_Modules_DontRemoveAI"; // Name displayed in the menu
		icon = "\A3A_Modules\data\icon_dontRemoveAI.paa"; // Map icon. Delete this entry to use the default icon
		category = "a3a_settings";

		function = "a3a_fnc_module_DontRemoveAI";
		functionPriority = 6;
		isGlobal = 0;
	};
	class A3A_NoFreezeVehicles: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "$STR_A3A_Modules_NoFreezeVehicles"; // Name displayed in the menu
		icon = "\A3A_Modules\data\icon_noFreezeVehicles.paa"; // Map icon. Delete this entry to use the default icon
		category = "a3a_settings";

		function = "a3a_fnc_module_NoFreezeVehicles";
		functionPriority = 7;
		isGlobal = 1;
	};
	class A3A_FreezeVehiclesTimer: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "$STR_A3A_Modules_FreezeVehiclesTimer"; // Name displayed in the menu
		icon = "\A3A_Modules\data\icon_freezeVehiclesTimer.paa"; // Map icon. Delete this entry to use the default icon
		category = "a3a_settings";

		function = "a3a_fnc_module_FreezeVehiclesTimer";
		functionPriority = 8;
		isGlobal = 0;
		class Arguments: ArgumentsBaseUnits
		{
			class Time
			{
				displayName = "$STR_A3A_Modules_FreezeVehiclesTimer_1_name";
				description = "$STR_A3A_Modules_FreezeVehiclesTimer_1_desc";
				typeName = "NUMBER";
				defaultValue = 10;
			};
			class Side
  			{
				displayName = "$STR_A3A_Modules_FreezeVehiclesTimer_2_name";
				description = "$STR_A3A_Modules_FreezeVehiclesTimer_2_desc";
				typeName = "NUMBER";
				class values
				{
					class value1 {name = "$STR_A3A_Modules_FreezeVehiclesTimer_NoMessage"; value = -2; };
					class value2 {name = "$STR_A3A_Modules_FreezeVehiclesTimer_GlobalMessage"; value = -1; default = 1; };
					class value3 {name = "WEST"; value = 0; };
					class value4 {name = "EAST"; value = 1; };
					class value5 {name = "RESISTANCE"; value = 2; };
				};
			};
			class Message
  			{
				displayName = "$STR_A3A_Modules_FreezeVehiclesTimer_3_name";
				description = "$STR_A3A_Modules_FreezeVehiclesTimer_3_desc";
				defaultValue = "Helicopters can fly now"; // Default text filled in the input box
				typeName = "STRING";
			};
			class Diary
  			{
				displayName = "$STR_A3A_Modules_WriteToDiary";
				description = "$STR_A3A_Modules_WriteToDiary_Desc";
				typeName = "BOOL";
			};
		};
	};
};

#include "CfgFunctions.hpp"
#include "RscTitles.hpp"