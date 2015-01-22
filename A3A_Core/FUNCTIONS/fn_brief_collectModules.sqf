private ["_diaryRecords", "_modules_list", "_module", "_diary", "_param_1", "_param_2", "_param_3", "_param_4", "_param_5"];

_diaryRecords = "";

/// END MISSION BY TIMER
_modules_list = allMissionObjects "A3A_EndMissionTimer";
for "_i" from 0 to ((count _modules_list) - 1) do {
	_module = _modules_list select _i;
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
		if (_diaryRecords != "") then { _diaryRecords = _diaryRecords + "<br/><br/>" };
		_diaryRecords = _diaryRecords + format[localize "STR_A3A_Modules_Diary_Timer", _param_1, _param_2];
	};
};

/// END MISSION CAPTURE
_modules_list = allMissionObjects "A3A_EndMissionCapture";
for "_i" from 0 to ((count _modules_list) - 1) do {
	_module = _modules_list select _i;
	_diary = _module getVariable ["Diary", true];
	if (_diary) then {
		//** PARAMETERS
		_param_1 = _module getVariable ["MarkerName", nil];
		_param_2 = _module getVariable ["AreaName", nil];
		_param_3 = _module getVariable ["CapTime", nil];
		_param_4 = _module getVariable ["HoldTime", nil];
		_param_5 = _module getVariable ["ChangeMarkerColor", nil];
		if (_param_5 == 0) then { _param_5 = false } else { _param_5 = true };
		//** PARAMETERS
		if (_diaryRecords != "") then { _diaryRecords = _diaryRecords + "<br/><br/>" };
		_diaryRecords = _diaryRecords + format[localize "STR_A3A_Modules_Diary_EndMissionCapture", _param_1, _param_2, _param_3, _param_4, _param_5];
	};
};

/// END MISSION COUNT UNITS
_modules_list = allMissionObjects "A3A_EndMissionCountUnits";
for "_i" from 0 to ((count _modules_list) - 1) do {
	_module = _modules_list select _i;
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
		if (_diaryRecords != "") then { _diaryRecords = _diaryRecords + "<br/><br/>" };
		_diaryRecords = _diaryRecords + format[localize "STR_A3A_Modules_Diary_EndMissionCountUnits", _param_1, _param_2, _param_3];
	};
};

/// END MISSION DEAD IN ZONE
_modules_list = allMissionObjects "A3A_EndMissionDeadInZone";
for "_i" from 0 to ((count _modules_list) - 1) do {
	_module = _modules_list select _i;
	_diary = _module getVariable ["Diary", true];
	if (_diary) then {
		//** PARAMETERS
		_param_1 = _module getVariable ["MinUnits", nil];
		_param_2 = synchronizedObjects _module;
		_param_3 = _module getVariable ["MarkerName", nil];
		_param_4 = _module getVariable ["AreaName", nil];
		if (_param_1 == 0) then { _param_1 = count _param_2 };
		//** PARAMETERS
		if (_diaryRecords != "") then { _diaryRecords = _diaryRecords + "<br/><br/>" };
		_diaryRecords = _diaryRecords + format[localize "STR_A3A_Modules_Diary_EndMissionDeadInZone", _param_1, count _param_2, _param_3, _param_4];
	};
};

/// COMBAT LOSSES
_modules_list = allMissionObjects "A3A_CombatLosses";
for "_i" from 0 to ((count _modules_list) - 1) do {
	_module = _modules_list select _i;
	_diary = _module getVariable ["Diary", true];
	if (_diary) then {
		//** PARAMETERS
		_param_1 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
		_param_2 = _module getVariable ["BFSideLoss", nil];
		_param_3 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));
		_param_4 = _module getVariable ["OFSideLoss", nil];
		_param_5 = _module getVariable ["SideSupremacy", nil];
		if (_param_5 < 0) then { _param_5 = 0 };
		//** PARAMETERS
		if (_diaryRecords != "") then { _diaryRecords = _diaryRecords + "<br/><br/>" };
		_diaryRecords = _diaryRecords + format[localize "STR_A3A_Modules_Diary_CombatLosses", _param_1, _param_2, _param_3, _param_4, _param_5];
	};
};

/// FREEZE VEHICLES TIMER
_modules_list = allMissionObjects "A3A_FreezeVehiclesTimer";
for "_i" from 0 to ((count _modules_list) - 1) do {
	_module = _modules_list select _i;
	_diary = _module getVariable ["Diary", true];
	if (_diary) then {
		//** PARAMETERS
		_freezeTime = _module getVariable ["Time", nil];
		_units = synchronizedObjects _module;
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
			if (_diaryRecords != "") then { _diaryRecords = _diaryRecords + "<br/><br/>" };
			_diaryRecords = _diaryRecords + format[localize "STR_A3A_Modules_Diary_FreezeVehiclesTimer", _freezeTime, _diaryUnits];
		};
	};
};

if (_diaryRecords != "") then { player createDiaryRecord ["diary", [localize "STR_A3A_Modules_Diary", _diaryRecords]] };