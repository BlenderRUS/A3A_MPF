class CfgPatches
{
	class CSSA3
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = { "A3_UI_F" };
		version = "1.0";
	};
};

#include "\CSSA3\CfgFunctions.hpp"
#include "\CSSA3\dialogs\basic_defines.hpp"
#include "\CSSA3\dialogs\CSSA3_defines.hpp"
#include "\CSSA3\dialogs\CSSA3_dialogs.hpp"

class CfgRespawnTemplates
{

	class Spectator
	{
		onPlayerKilled = "";
		onPlayerRespawn = "CSSA3_fnc_init";
	};
	class Seagull
	{
		onPlayerRespawn = "CSSA3_fnc_init";
	};
};