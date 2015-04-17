class CfgPatches
{
   class A3A_Core
	{
		units[]={};
		weapons[]={};
		requiredAddons[]={ "A3_UI_F", "A3A_Modules" };
		requiredVersion=1.38;
		version = "1.2.1";
		versionStr = "1.2.1";
		versionAr[] = {1,2,1};
		author[] = { "Blender" };
		authorUrl = "http://www.arma3.ru";
   };
};

#include "Dialogs\BaseClasses.h" // INIT RSC BASE CLASSES
#include "Dialogs\Dialogs.hpp"
#include "VIEWDISTANCE\Dialog.hpp"

class CfgDebriefing
{  
	class A3A_End_1
	{
		title = "Mission Ended";
		pictureBackground = "\A3A_Core\Resources\a3a_end_1.paa";
	};
};

class RscTitles {
	#include "Dialogs\Counter.hpp"
	#include "Dialogs\RscTitles.hpp"
};

#include "CfgSounds.hpp"
#include "CfgFunctions.hpp"