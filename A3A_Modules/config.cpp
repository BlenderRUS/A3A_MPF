#define _ARMA_
class CfgPatches
{
	class A3A_Modules
	{
		units[] = {"A3A_EndMissionTimer", "A3A_EndMissionCapture", "A3A_EndMissionCountUnits", "A3A_EndMissionDeadInZone", "A3A_CombatLosses", "A3A_NoFreezeVehicles", "A3A_DontRemoveAI", "A3A_FreezeVehiclesTimer"};
		requiredAddons[] = { A3_Modules_F };
		requiredVersion = 1.38;
		version = "1.2.1";
		versionStr = "1.2.1";
		versionAr[] = {1,2,1};
		author[] = { "Blender" };
		authorUrl = "http://www.arma3.ru";
	};
};

class Extended_PostInit_EventHandlers {
	A3A_Modules_postinit = "[] execVM '\A3A_Modules\Init.sqf';";
};

class RscPicture;
class RscStructuredText;

#include "CfgFunctions.hpp"
#include "RscTitles.hpp"
#include "CfgMusic.hpp"
#include "Dialogs\dialog_endMission.hpp"
#include "ModulesCfg.hpp"