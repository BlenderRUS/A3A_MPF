disableSerialization;
#include "\A3A_Core\VIEWDISTANCE\macros.h"

private "_display";
_display = uiNameSpace getVariable ["A3A_ViewDistance", displayNull];
if (!isNull _display) then {
	a3a_var_viewDistance_infantry = round(sliderPosition(_display displayCtrl IDC_A3A_VIEWDISTANCE_SLIDER_INFANTRY));
	a3a_var_viewDistance_vehicle = round(sliderPosition(_display displayCtrl IDC_A3A_VIEWDISTANCE_SLIDER_VEHICLE));
	a3a_var_viewDistance_air = round(sliderPosition(_display displayCtrl IDC_A3A_VIEWDISTANCE_SLIDER_AIR));
	
	// SAVE TO PROFILE
	profileNameSpace setVariable ["A3A_var_viewDistance_Infantry", a3a_var_viewDistance_infantry];
	profileNameSpace setVariable ["A3A_var_viewDistance_Vehicle", a3a_var_viewDistance_vehicle];
	profileNameSpace setVariable ["A3A_var_viewDistance_Air", a3a_var_viewDistance_air];
	saveProfileNameSpace;
};