class A3A_ExternalFile: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_externalFile"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_externalFile.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_settings";

	function = "a3a_fnc_module_externalFile";
	functionPriority = 13;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class ModuleName
		{
			displayName = "$STR_A3A_Modules_ExternalFile_1_Name";
			description = "$STR_A3A_Modules_ExternalFile_1_Desc";
			defaultValue = "MY MODULE NAME";
			typeName = "STRING";
		};
		class FilePath
		{
			displayName = "$STR_A3A_Modules_ExternalFile_2_Name";
			description = "$STR_A3A_Modules_ExternalFile_2_Desc";
			defaultValue = "myMissionFile.sqf";
			typeName = "STRING";
		};
		#include "Diary.hpp"
		#include "Order.hpp"
	};
};