class A3A_DontRemoveAI: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "$STR_A3A_Modules_DontRemoveAI"; // Name displayed in the menu
	icon = "\A3A_Modules\data\icon_dontRemoveAI.paa"; // Map icon. Delete this entry to use the default icon
	category = "a3a_settings";

	function = "a3a_fnc_module_DontRemoveAI";
	functionPriority = 6;
	isGlobal = 0;
};