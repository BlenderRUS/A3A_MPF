private ["_fnc_getModules", "_module", "_modules", "_param"];
_fnc_getModule = {
	_modules = allMissionObjects "A3A_Settings";
	_module = objNull;
	if (count _modules > 0) then { _module = _modules select 0 };
	_module
};

_module = [] call _fnc_getModule;

switch (toUpper _this) do {
	case "BFSIDE": {
		if (isNil "A3A_var_settings_BFSide") then {
			A3A_var_settings_BFSide = call compile (_module getVariable ["BFSide", getText (missionConfigFile >> "A3A_MissionParams" >> "blueforSide")]);
		};
		A3A_var_settings_BFSide
	};
	case "OFSIDE": {
		if (isNil "A3A_var_settings_OFSide") then {
			A3A_var_settings_OFSide = call compile (_module getVariable ["OFSide", getText (missionConfigFile >> "A3A_MissionParams" >> "opforSide")]);
		};
		A3A_var_settings_OFSide
	};
	case "PREPAREZONESIZE": {
		_param = _module getVariable ["PrepareZoneSize", getNumber (missionConfigFile >> "A3A_MissionParams" >> "prepareZoneSize")];
		_param
	};
	case "UAVINTRO": {
		_param = _module getVariable ["UAVIntro", getNumber (missionConfigFile >> "A3A_MissionParams" >> "UAVIntro")];
		_param
	};
	case "FIRETEAMHUD": {
		_param = _module getVariable ["FireteamHUD", getNumber (missionConfigFile >> "A3A_MissionParams" >> "fireteamHUD")];
		_param
	};
	case "VIEWDISTANCE": {
		_param = _module getVariable ["ViewDistance", getNumber (missionConfigFile >> "A3A_MissionParams" >> "viewDistance")];
		_param
	};
	case "NOCLIENTVIEWDISTANCE": {
		_param = _module getVariable ["NoClientViewDistance", getNumber (missionConfigFile >> "A3A_MissionParams" >> "disable_viewDistance_dialog")];
		_param
	};
	case "DAYTIMENVG": {
		_param = _module getVariable ["DaytimeNVG", getNumber (missionConfigFile >> "A3A_MissionParams" >> "daytimeNVG")];
		_param
	};
	case "EQUIPMENTDIALOG": {
		_param = _module getVariable ["EquipmentDialog", getNumber (missionConfigFile >> "A3A_MissionParams" >> "equipmentDialog")];
		_param
	};
	default { "fn_Modules_GetSettings ERROR" hintC ["Unknown settings:", _this]; diag_log "[A3A SETTINGS] Unknown: " + _this };
};