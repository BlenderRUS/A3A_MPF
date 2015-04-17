waitUntil { !isNil "a3a_var_modules_order" };

_settingsModules = allMissionObjects "A3A_Settings";
if (count _settingsModules > 0) then {
	private ["_fnc_getSide", "_fnc_getBoolNum", "_modules", "_diary", "_param_1", "_param_2", "_param_3", "_param_4", "_param_5", "_param_6", "_param_7", "_param_8", "_param_9"];
	_fnc_getSide = {
		private "_side";
		_side = "UNKNOWN";
		switch _this do {
			case "EAST": { _side = localize "STR_A3A_Modules_West" };
			case "WEST": { _side = localize "STR_A3A_Modules_East" };
			case "RESISTANCE": { _side = localize "STR_A3A_Modules_Resistance" };
		};
		_side
	};
	_fnc_getBoolNum = {	if (_this isEqualTo 0) then { localize "STR_A3A_Modules_No" } else { localize "STR_A3A_Modules_Yes" } };
	_module = _settingsModules select 0;
	_diary = _module getVariable ["Diary", true];
	if (_diary) then {
		//** PARAMETERS
		_param_1 = (_module getVariable ["BFSide", "UNKNOWN"]) call _fnc_getSide;
		_param_2 = (_module getVariable ["OFSide", "UNKNOWN"]) call _fnc_getSide;
		_param_3 = _module getVariable ["PrepareZoneSize", 0];
		_param_4 = (_module getVariable ["UAVIntro", 0]) call _fnc_getBoolNum;
		_param_5 = (_module getVariable ["FireteamHUD", 0]) call _fnc_getBoolNum;
		_param_6 = _module getVariable ["ViewDistance", 0];
		_param_7 = (_module getVariable ["NoClientViewDistance", 0]) call _fnc_getBoolNum;
		_param_8 = (_module getVariable ["DaytimeNVG", 0]) call _fnc_getBoolNum;
		_param_9 = (_module getVariable ["EquipmentDialog", 0]) call _fnc_getBoolNum;
		//** PARAMETERS
		player createDiaryRecord ["diary", [
			localize "STR_A3A_Modules_Diary_Settings_Title",
			format[localize "STR_A3A_Modules_Diary_Settings", _param_1, _param_2, _param_3, _param_4, _param_5, _param_6, _param_7, _param_8, _param_9]
		]];
	};
};

_fnc_getModuleInfo = {
	private ["_module", "_return", "_diary", "_param_1", "_param_2", "_param_3", "_param_4", "_param_5", "_param_6"];
	_module = _this;
	_return = "";
	switch (true) do {
		case (_module in (allMissionObjects "A3A_EndMissionTimer")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_param_1 = _module getVariable "Time";
				_param_1 = _param_1 / 60;
				switch (_module getVariable "Side") do {
					case 0: { _param_2 = WEST };
					case 1: { _param_2 = EAST };
					case 2: { _param_2 = RESISTANCE };
				};
				//** PARAMETERS
				_return = format[localize "STR_A3A_Modules_Diary_Timer", _param_1, _param_2];
			};
		};
		case (_module in (allMissionObjects "A3A_EndMissionCapture")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_param_1 = _module getVariable ["MarkerName", nil];
				_param_2 = _module getVariable ["AreaName", nil];
				_param_3 = _module getVariable ["CapTime", nil];
				_param_4 = _module getVariable ["HoldTime", nil];
				_param_5 = _module getVariable ["ChangeMarkerColor", nil];
				_param_6 = _module getVariable ["CaptureSide", 0];
				if (_param_5 == 0) then { _param_5 = false } else { _param_5 = true };
				switch (_param_6) do {
							case 0: { _param_6 = localize "STR_A3A_Modules_Every1" };
							case 1: { _param_6 = localize "STR_A3A_Modules_West" };
							case 2: { _param_6 = localize "STR_A3A_Modules_East" };
							case 3: { _param_6 = localize "STR_A3A_Modules_Resistance" };
						};
				//** PARAMETERS
				_return = format[localize "STR_A3A_Modules_Diary_EndMissionCapture", _param_1, _param_2, _param_3, _param_4, _param_5, _param_6];
			};
		};
		case (_module in (allMissionObjects "A3A_EndMissionCountUnits")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_param_1 = _module getVariable ["MinMan", nil];
				_param_2 = _module getVariable ["Side", nil];
				_param_3 = _module getVariable ["MarkerName", nil];
				switch (_param_2) do {
					case 0: { _param_2 = WEST };
					case 1: { _param_2 = EAST };
					case 2: { _param_2 = RESISTANCE };
				};
				//** PARAMETERS
				_return = format[localize "STR_A3A_Modules_Diary_EndMissionCountUnits", _param_1, _param_2, _param_3];
			};
		};
		case (_module in (allMissionObjects "A3A_EndMissionDeadInZone")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_param_1 = _module getVariable ["MinUnits", nil];
				_param_2 = synchronizedObjects _module;
				_param_3 = _module getVariable ["MarkerName", nil];
				_param_4 = _module getVariable ["AreaName", nil];
				if (_param_1 == 0) then { _param_1 = count _param_2 };
				//** PARAMETERS
				_return = format[localize "STR_A3A_Modules_Diary_EndMissionDeadInZone", _param_1, count _param_2, _param_3, _param_4];
			};
		};
		case (_module in (allMissionObjects "A3A_CombatLosses")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_param_1 = "BFSIDE" call A3A_fnc_Modules_GetSettings;
				_param_2 = _module getVariable ["BFSideLoss", nil];
				_param_3 = "OFSIDE" call A3A_fnc_Modules_GetSettings;
				_param_4 = _module getVariable ["OFSideLoss", nil];
				_param_5 = _module getVariable ["SideSupremacy", nil];
				if (_param_5 <= 0) then { _param_5 = localize "STR_A3A_Modules_Disabled" };
				//** PARAMETERS
				_return = format[localize "STR_A3A_Modules_Diary_CombatLosses", _param_1, _param_2, _param_3, _param_4, _param_5];
			};
		};
		case (_module in (allMissionObjects "A3A_FreezeVehiclesTimer")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_freezeTime = _module getVariable ["Time", nil];
				_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;
				_side = _module getVariable ["Side", nil];
				//** PARAMETERS
				_processDiary = false;
				if (_side > -2) then {
					if (_side == -1) then {
						_processDiary = true;
					} else {
						_diarySide = CIVILIAN;
						switch (_side) do {
							case 0: { _diarySide = WEST };
							case 1: { _diarySide = EAST };
							case 2: { _diarySide = RESISTANCE };
						};
						if (playerSide == _diarySide) then {
							_processDiary = true;
						};
					};
				};
				if (_processDiary) then {
					_diaryUnits = "";
					_diaryCountUnits = (count _units) - 1;
					for "_i" from 0 to _diaryCountUnits do {
						_diaryUnits = _diaryUnits + (getText (configFile >> "CfgVehicles" >> (typeOf (_units select _i)) >> "displayName"));
						if (_i != _diaryCountUnits) then {
							_diaryUnits = _diaryUnits + ", "
						};
					};
					_return = format[localize "STR_A3A_Modules_Diary_FreezeVehiclesTimer", _freezeTime, _diaryUnits];
				};
			};
		};
		case (_module in (allMissionObjects "A3A_LockVehiclesTimer")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_lockTime = _module getVariable ["Time", nil];
				_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;
				_side = _module getVariable ["Side", nil];
				//** PARAMETERS
				_processDiary = false;
				if (_side > -2) then {
					if (_side == -1) then {
						_processDiary = true;
					} else {
						_diarySide = CIVILIAN;
						switch (_side) do {
							case 0: { _diarySide = WEST };
							case 1: { _diarySide = EAST };
							case 2: { _diarySide = RESISTANCE };
						};
						if (playerSide == _diarySide) then {
							_processDiary = true;
						};
					};
				};
				if (_processDiary) then {
					_diaryUnits = "";
					_diaryCountUnits = (count _units) - 1;
					for "_i" from 0 to _diaryCountUnits do {
						_diaryUnits = _diaryUnits + (getText (configFile >> "CfgVehicles" >> (typeOf (_units select _i)) >> "displayName"));
						if (_i != _diaryCountUnits) then {
							_diaryUnits = _diaryUnits + ", "
						};
					};
					_return = format[localize "STR_A3A_Modules_Diary_LockVehiclesTimer", _lockTime, _diaryUnits];
				};
			};
		};
		case (_module in (allMissionObjects "A3A_EndMissionVipInZone")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				
				_marker = _module getVariable ["MarkerName", nil];
				_minUnits = _module getVariable ["MinUnits", nil];
				_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;
				_side = _module getVariable ["Side", nil];
				//** PARAMETERS
				_processDiary = false;
				if (_side > -2) then {
					if (_side == -1) then {
						_processDiary = true;
					} else {
						_diarySide = CIVILIAN;
						switch (_side) do {
							case 0: { _diarySide = WEST };
							case 1: { _diarySide = EAST };
							case 2: { _diarySide = RESISTANCE };
						};
						if (playerSide == _diarySide) then {
							_processDiary = true;
						};
					};
				};
				if (_processDiary) then {
					_diaryUnits = "";
					_diaryCountUnits = (count _units) - 1;
					for "_i" from 0 to _diaryCountUnits do {
						_diaryUnits = _diaryUnits + (getText (configFile >> "CfgVehicles" >> (typeOf (_units select _i)) >> "displayName"));
						if (_i != _diaryCountUnits) then {
							_diaryUnits = _diaryUnits + ", "
						};
					};
					_return = format[localize "STR_A3A_Modules_Diary_EndMissionVipInZone", _minUnits, _diaryUnits, _marker];
				};
			};
		};
		case (_module in (allMissionObjects "A3A_EndMissionDeadUnits")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_param_1 = _module getVariable ["MinUnits", nil];
				_param_2 = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;
				if (_param_1 == 0) then { _param_1 = count _param_2 };
				//** PARAMETERS
				_return = format[localize "STR_A3A_Modules_Diary_EndMissionDeadUnits", _param_1, count _param_2];
			};
		};
		case (_module in (allMissionObjects "A3A_EndMissionExternalFile")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_param_1 = _module getVariable ["ModuleName", nil];
				//** PARAMETERS
				_return = format[localize "STR_A3A_Modules_Diary_EndMissionExternalFile", _param_1];
			};
		};
		case (_module in (allMissionObjects "A3A_EndMissionEscapeFromZone")): {
			_diary = _module getVariable ["Diary", true];
			if (_diary) then {
				//** PARAMETERS
				_marker = _module getVariable ["MarkerName", nil];
				_areaName = _module getVariable ["AreaName", nil];
				_minUnits = _module getVariable ["MinUnits", nil];
				_winSide = _module getVariable ["WinSide", nil];
				_timeToEscape = _module getVariable ["TimeToEscape", nil];
				_unitsCount = count ((synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules);
				
				if (_minUnits == 0) then { _minUnits = _unitsCount };
				//** PARAMETERS
				switch (_winSide) do {
					case 0: { _winSide = WEST };
					case 1: { _winSide = EAST };
					case 2: { _winSide = RESISTANCE };
				};
				if (_timeToEscape <= 0) then { _timeToEscape = localize "STR_A3A_Modules_Disabled" };
				_return = format[localize "STR_A3A_Modules_Diary_EndMissionEscapeFromZone", _minUnits, _unitsCount, _winSide, _marker, _areaName, _timeToEscape];
			};
		};
	};
	_return
};

private ["_diaryRecords", "_totalGroups", "_order", "_module", "_mod_info"];
_diaryRecords = "";
_totalGroups = 0;

{
	_order = 0;
	if (_diaryRecords != "") then { _diaryRecords = _diaryRecords + "<br/>" };
	if ((count a3a_var_modules_order) > 1) then {
		_totalGroups = _totalGroups + 1;
		_diaryRecords = _diaryRecords + format[localize "STR_A3A_Modules_Group", _totalGroups];
	};
	for "_i" from 0 to ((count _x) - 1) do {
		if ((count _x) > 1) then {
			_order = _order + 1;
			_diaryRecords = _diaryRecords + format[localize "STR_A3A_Modules_Order", _order];
		};
		_mods = _x select _i;
		for "_i2" from 0 to ((count _mods) - 1) do {
			_module = _mods select _i2;
			_mod_info = _module call _fnc_getModuleInfo;
			if (_mod_info != "") then {
				_diaryRecords = _diaryRecords + "<br/>" + _mod_info;
			} else {
				_diaryRecords = _diaryRecords + "<br/>" + (localize "STR_A3A_Modules_HiddenModule");
			};
		};
	};
	
} forEach a3a_var_modules_order;

if (_diaryRecords != "") then { player createDiaryRecord ["diary", [localize "STR_A3A_Modules_Diary", _diaryRecords]] };