#include "\A3A_Core\VIEWDISTANCE\macros.h"

createDialog "A3A_ViewDistance";

disableSerialization;
_display = uiNameSpace getVariable ["A3A_ViewDistance", displayNull];
if (!isNull _display) then {
	// MAX DISTANCE TEXT
	(_display displayCtrl IDC_A3A_VIEWDISTANCE_TEXT_MAX) ctrlSetText format[localize "STR_A3A_ViewDistance_Max", a3a_var_viewDistance_max];

	// INFANTRY
	_ctrl_edit = _display displayCtrl IDC_A3A_VIEWDISTANCE_EDIT_INFANTRY;
	_ctrl_edit ctrlSetText str a3a_var_viewDistance_infantry;
	_ctrl_edit ctrlAddEventHandler ["KillFocus", {
		_ctrl = _this select 0;
		_ctrlSlider = uiNameSpace getVariable ["A3A_ViewDistance", displayNull] displayCtrl IDC_A3A_VIEWDISTANCE_SLIDER_INFANTRY;
		_distance = parseNumber (ctrlText _ctrl);
		if ((_distance < 200) || (_distance > a3a_var_viewDistance_max)) then {
			_ctrl ctrlSetText str round(sliderPosition _ctrlSlider);
		} else {
			_ctrlSlider sliderSetPosition _distance;
		};
	}];

	_ctrl_slider = _display displayCtrl IDC_A3A_VIEWDISTANCE_SLIDER_INFANTRY;
	_ctrl_slider sliderSetRange [200, a3a_var_viewDistance_max];
	_ctrl_slider sliderSetPosition a3a_var_viewDistance_infantry;
	_ctrl_slider ctrlAddEventHandler ["SliderPosChanged", {
		_display = uiNameSpace getVariable ["A3A_ViewDistance", displayNull];
		(_display displayCtrl IDC_A3A_VIEWDISTANCE_EDIT_INFANTRY) ctrlSetText str round(_this select 1);
	}];

	// VEHICLE
	_ctrl_edit = _display displayCtrl IDC_A3A_VIEWDISTANCE_EDIT_VEHICLE;
	_ctrl_edit ctrlSetText str a3a_var_viewDistance_vehicle;
	_ctrl_edit ctrlAddEventHandler ["KillFocus", {
		_ctrl = _this select 0;
		_ctrlSlider = uiNameSpace getVariable ["A3A_ViewDistance", displayNull] displayCtrl IDC_A3A_VIEWDISTANCE_SLIDER_VEHICLE;
		_distance = parseNumber (ctrlText _ctrl);
		if ((_distance < 200) || (_distance > a3a_var_viewDistance_max)) then {
			_ctrl ctrlSetText str round(sliderPosition _ctrlSlider);
		} else {
			_ctrlSlider sliderSetPosition _distance;
		};
	}];

	_ctrl_slider = _display displayCtrl IDC_A3A_VIEWDISTANCE_SLIDER_VEHICLE;
	_ctrl_slider sliderSetRange [200, a3a_var_viewDistance_max];
	_ctrl_slider sliderSetPosition a3a_var_viewDistance_vehicle;
	_ctrl_slider ctrlAddEventHandler ["SliderPosChanged", {
		_display = uiNameSpace getVariable ["A3A_ViewDistance", displayNull];
		(_display displayCtrl IDC_A3A_VIEWDISTANCE_EDIT_VEHICLE) ctrlSetText str round(_this select 1);
	}];

	// AIR
	_ctrl_edit = _display displayCtrl IDC_A3A_VIEWDISTANCE_EDIT_AIR;
	_ctrl_edit ctrlSetText str a3a_var_viewDistance_air;
	_ctrl_edit ctrlAddEventHandler ["KillFocus", {
		_ctrl = _this select 0;
		_ctrlSlider = uiNameSpace getVariable ["A3A_ViewDistance", displayNull] displayCtrl IDC_A3A_VIEWDISTANCE_SLIDER_AIR;
		_distance = parseNumber (ctrlText _ctrl);
		if ((_distance < 200) || (_distance > a3a_var_viewDistance_max)) then {
			_ctrl ctrlSetText str round(sliderPosition _ctrlSlider);
		} else {
			_ctrlSlider sliderSetPosition _distance;
		};
	}];

	_ctrl_slider = _display displayCtrl IDC_A3A_VIEWDISTANCE_SLIDER_AIR;
	_ctrl_slider sliderSetRange [200, a3a_var_viewDistance_max];
	_ctrl_slider sliderSetPosition a3a_var_viewDistance_air;
	_ctrl_slider ctrlAddEventHandler ["SliderPosChanged", {
		_display = uiNameSpace getVariable ["A3A_ViewDistance", displayNull];
		(_display displayCtrl IDC_A3A_VIEWDISTANCE_EDIT_AIR) ctrlSetText str round(_this select 1);
	}];

	// BUTTON
	(_display displayCtrl IDC_A3A_VIEWDISTANCE_BTN_OK) buttonSetAction "[] call A3A_fnc_ViewDistance_Confirm; closeDialog 0;";
};