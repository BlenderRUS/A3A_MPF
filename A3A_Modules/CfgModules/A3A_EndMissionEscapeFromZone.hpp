class A3A_EndMissionEscapeFromZone: Module_F
{
	scope = 2;
	displayName = "$STR_A3A_Modules_EndMissionEscapeFromZone";
	icon = "\A3A_Modules\data\icon_EndMissionEscapeFromZone.paa";
	category = "a3a_ending";

	function = "A3A_fnc_Module_EndMissionEscapeFromZone";
	functionPriority = 1;
	isGlobal = 0;
	
	class Arguments: ArgumentsBaseUnits
	{
		class MarkerName
		{
			displayName = "$STR_A3A_Modules_EndMissionEscapeFromZone_1_Name";
			description = "$STR_A3A_Modules_EndMissionEscapeFromZone_1_Desc";
			defaultValue = "marker_1";
			typeName = "STRING";
		};
		class AreaName
		{
			displayName = "$STR_A3A_Modules_EndMissionEscapeFromZone_2_Name";
			description = "$STR_A3A_Modules_EndMissionEscapeFromZone_2_Desc";
			defaultValue = "My zone";
			typeName = "STRING";
		};
		class MinUnits
		{
			displayName = "$STR_A3A_Modules_EndMissionEscapeFromZone_3_Name";
			description = "$STR_A3A_Modules_EndMissionEscapeFromZone_3_Desc";
			typeName = "NUMBER";
			defaultValue = 0;
		};
		class TimeToEscape
		{
			displayName = "$STR_A3A_Modules_EndMissionEscapeFromZone_4_Name";
			description = "$STR_A3A_Modules_EndMissionEscapeFromZone_4_Desc";
			typeName = "NUMBER";
			defaultValue = 0;
		};
		class WinSide
		{
			displayName = "$STR_A3A_Modules_EndMissionEscapeFromZone_5_Name";
			description = "$STR_A3A_Modules_EndMissionEscapeFromZone_5_Desc";
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