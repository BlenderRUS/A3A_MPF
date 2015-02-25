class CfgPatches
{
   class A3A_Core
	{
		units[]={};
		weapons[]={};
		requiredAddons[]={ "A3A_Modules" };
		requiredVersion=1.38;
		version = "1.2";
		versionStr = "1.2";
		versionAr[] = {1,2};
		author[] = { "Blender" };
		authorUrl = "http://www.arma3.ru";
   };
};

#include "Dialogs\Dialogs.hpp"

class CfgDebriefing
{  
	class A3A_End_1
	{
		title = "Mission Ended";
		pictureBackground = "\A3A_Core\Resources\a3a_end_1.paa";
	};
};

// DEFINE RSC TITLES BASE CLASSES
class IGUIBack;
class RscText;
class RscStructuredText;
class RscPicture;

class RscTitles {
	#include "Dialogs\Counter.hpp"
	#include "Dialogs\RscTitles.hpp"
};

#include "CfgSounds.hpp"
#include "CfgFunctions.hpp"