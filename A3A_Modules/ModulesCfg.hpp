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
	#include "CfgModules\A3A_EndMissionTimer.hpp"
	#include "CfgModules\A3A_EndMissionCapture.hpp"
	#include "CfgModules\A3A_EndMissionCountUnits.hpp"
	#include "CfgModules\A3A_EndMissionDeadInZone.hpp"
	#include "CfgModules\A3A_CombatLosses.hpp"
	#include "CfgModules\A3A_DontRemoveAI.hpp"
	#include "CfgModules\A3A_NoFreezeVehicles.hpp"
	#include "CfgModules\A3A_FreezeVehiclesTimer.hpp"
	#include "CfgModules\A3A_LockVehiclesTimer.hpp"
	#include "CfgModules\A3A_EndMissionVipInZone.hpp"
	#include "CfgModules\A3A_EndMissionDeadUnits.hpp"
	#include "CfgModules\A3A_EndMissionExternalFile.hpp"
	#include "CfgModules\A3A_ExternalFile.hpp"
	#include "CfgModules\A3A_ObjectsRandomizer.hpp"
	#include "CfgModules\A3A_EndMissionEscapeFromZone.hpp"
};