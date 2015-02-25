class A3A_EndMissionExternalFile: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_EndMissionExternalFile"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_endMissionExternalFile.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_ending";

	function = "a3a_fnc_module_EndMissionExternalFile";
	functionPriority = 12;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class ModuleName
		{
			displayName = "$STR_A3A_Modules_EndMissionExternalFile_1_Name";
			description = "$STR_A3A_Modules_EndMissionExternalFile_1_Desc";
			defaultValue = "MY ENDING MODULE";
			typeName = "STRING";
		};
		class FilePath
		{
			displayName = "$STR_A3A_Modules_EndMissionExternalFile_2_Name";
			description = "$STR_A3A_Modules_EndMissionExternalFile_2_Desc";
			defaultValue = "myMissionFile.sqf";
			typeName = "STRING";
		};
		#include "Diary.hpp"
		#include "Order.hpp"
	};
};