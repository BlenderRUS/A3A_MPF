if (("NOCLIENTVIEWDISTANCE" call A3A_fnc_Modules_GetSettings) != 1) then {
	if (isNil "a3a_var_viewDistance_max") then {
		a3a_var_viewDistance_max = "VIEWDISTANCE" call A3A_fnc_Modules_GetSettings;
	};

	if (a3a_var_viewDistance_max isEqualTo 0) then { a3a_var_viewDistance_max = 3500 };

	// LOAD PROFILE VALUES
	_infantry = profileNamespace getVariable ["A3A_var_viewDistance_Infantry", a3a_var_viewDistance_max];
	if (_infantry < 200 || _infantry > a3a_var_viewDistance_max) then {
		a3a_var_viewDistance_infantry = a3a_var_viewDistance_max;
	} else {
		a3a_var_viewDistance_infantry = _infantry;
	};
	
	_vehicle = profileNamespace getVariable ["A3A_var_viewDistance_Vehicle", a3a_var_viewDistance_max];
	if (_vehicle < 200 || _vehicle > a3a_var_viewDistance_max) then {
		a3a_var_viewDistance_vehicle = a3a_var_viewDistance_max;
	} else {
		a3a_var_viewDistance_vehicle = _vehicle;
	};
	
	_air = profileNamespace getVariable ["A3A_var_viewDistance_Air", a3a_var_viewDistance_max];
	if (_air < 200 || _air > a3a_var_viewDistance_max) then {
		a3a_var_viewDistance_air = a3a_var_viewDistance_max;
	} else {
		a3a_var_viewDistance_air = _air;
	};
	
	// Добавление в меню действий
	[
		localize 'STR_A3A_ViewDistance_Action',
		'[]',
		'A3A_fnc_ViewDistance',
		'true'
	] call a3a_fnc_ui_add;

	[] spawn {
		while { alive player } do {
			[] call A3A_fnc_ViewDistance_CheckSet;
			sleep 1.217;
		};
	};
};