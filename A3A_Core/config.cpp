class CfgPatches
{
   class A3A_Core
	{
		units[]={};
		weapons[]={};
		requiredAddons[]={ "A3A_Modules" };
		requiredVersion=1.38;
		version = "1.03";
		versionStr = "1.03";
		versionAr[] = {1,0,3};
		author[] = { "Blender" };
		authorUrl = "http://www.arma3.ru";
   };
};

#include "Dialogs\Dialogs.hpp"

// DEFINE RSC TITLES BASE CLASSES
class RscText;
class RscStructuredText;
class RscPicture;

class RscTitles {
	#include "Dialogs\Counter.hpp"
	#include "Dialogs\RscTitles.hpp"
};

#include "CfgSounds.hpp"