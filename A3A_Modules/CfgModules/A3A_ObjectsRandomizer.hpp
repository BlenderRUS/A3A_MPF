class A3A_ObjectsRandomizer: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_ObjectsRandomizer"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_objectsRandomizer.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_settings";
	
	function = "A3A_fnc_Modules_Dummy";
	functionPriority = 13;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class Mirrored
		{
			displayName = "$STR_A3A_Modules_ObjectsRandomizer_1_Name";
			description = "$STR_A3A_Modules_ObjectsRandomizer_1_Desc";
			typeName = "BOOL";
			class values {
				class value0 {name = "No"; value = 0; default = 1; };
				class value1 {name = "Yes"; value = 1; };
			};
		};
		#include "Diary.hpp"
	};
};