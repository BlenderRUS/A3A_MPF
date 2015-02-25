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
		#include "Diary.hpp"
	};
};