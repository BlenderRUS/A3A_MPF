#define MODULE_NAME "End Mission Escape From Zone"
private [
	"_module",
	"_units",
	"_marker",
	"_areaName",
	"_minUnits",
	"_timeToEscape",
	"_winSide",
	"_errors",
	"_var_mod_started",
	"_timerStarted",
	"_random",
	"_rectangle",
	"_direction",
	"_triggerArea",
	"_trigger",
	"_running",
	"_inListCheck",
	"_deadUnits",
	"_zoneLeftUnits",
	"_totalUnits"
];

_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;

////// PARAMETERS //////
_marker = _module getVariable ["MarkerName", -64];
_areaName = _module getVariable ["AreaName", -64];
_minUnits = _module getVariable ["MinUnits", -64];
_timeToEscape = _module getVariable ["TimeToEscape", -64];
_winSide = _module getVariable ["WinSide", -64];

switch (_winSide) do {
	case 0: { _winSide = WEST };
	case 1: { _winSide = EAST };
	case 2: { _winSide = RESISTANCE };
};

_errors = [MODULE_NAME,
	[
		["MARKER", _marker],
		["AREA_NAME", _areaName],
		["MIN_MAX", _minUnits, 0, count _units],
		["MIN_MAX", _timeToEscape, 0],
		["SIDE_COMP", _winSide]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

if (_minUnits == 0) then { _minUnits = count _units };
if (_timeToEscape > 0) then { _timeToEscape = _timeToEscape * 60 };

_fnc_getName = {
	private ["_type", "_name"];
	_type = typeOf _this;
	if (_type isKindOf "Man") then {
		_name = name _this;
		if (_name == "Error: No unit") then { _name = "Mission Target" };
	} else {
		_name = getText(configFile >> "CfgVehicles" >> _type >> "displayName");
		if (_name == "") then { _name = _type };
	};
	_name
};

//// DISABLE LOAD ITEMS TO VEHICLE CARGO
for "_i" from 0 to ((count _units) - 1) do {
	_unit = _units select _i;
	if (isClass (configFile >> "CfgVehicles" >> (typeOf _unit) >> "AGM_Actions" >> "AGM_loadItem")) then {
		_unit setVariable ["AGM_Logistics_CanLoadItem", false, true];
	};
};

waitUntil { sleep 0.921; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

_timerStarted = if (_timeToEscape == 0) then { 0 } else { diag_tickTime };

_random = 5 + (random 1);

// Marker Shape
_rectangle = if ((markerShape _marker) == "RECTANGLE") then { true } else { false };
_direction = markerDir _marker;

// Create Trigger
_triggerArea = [(markerSize _marker) select 0, (markerSize _marker) select 1, _direction, _rectangle];
_trigger = createTrigger["EmptyDetector", getMarkerPos _marker];
_trigger setTriggerArea _triggerArea;
_trigger setTriggerActivation["ANY", "PRESENT", false];
_trigger setTriggerStatements["false", "", ""];
_trigger setTriggerTimeout [15, 15, 15, false];

waitUntil { sleep 0.161; _ls = list _trigger; !isNil "_ls" };

_running = true;

_inListCheck = []; // 2nd check for absent units (getIn/getOut vehicle bug related)
_deadUnits = 0; // Dead units count
_zoneLeftUnits = 0; // Units which escaped the zone
_totalUnits = count _units;

while {_running} do {
	_unitsList = (list _trigger) call A3A_fnc_Modules_GetCrewUnits;
	_tempUnits = _units;
	for "_i" from 0 to ((count _tempUnits) - 1) do {
		_unit = _tempUnits select _i;
		if (isNull _unit) then {
			_units = _units - [_unit];
			_deadUnits = _deadUnits + 1;
		} else {
			if !(alive _unit) then {
				_units = _units - [_unit];
				_name = _unit call _fnc_getName;
				_deadUnits = _deadUnits + 1;
				[["STR_A3A_Modules_isDead", _name, _areaName], 1] call a3a_fnc_message;
			} else {
				if !(_unit in _unitsList) then {
					if (_unit in _inListCheck) then {
						_units = _units - [_unit];
						_inListCheck = _inListCheck - [_unit];
						_name = _unit call _fnc_getName;
						_zoneLeftUnits = _zoneLeftUnits + 1;
						//** ENABLE ITEM LOAD TO VEHICLES
						if (isClass (configFile >> "CfgVehicles" >> (typeOf _unit) >> "AGM_Actions" >> "AGM_loadItem")) then {
							_unit setVariable ["AGM_Logistics_CanLoadItem", nil, true];
						};
						//// ENABLE ITEM LOAD TO VEHICLES
						[["STR_A3A_Modules_escapedFromZone", _name, _areaName, _zoneLeftUnits, _minUnits], 0] call a3a_fnc_message;
					} else {
						_inListCheck pushBack _unit;
					};
				} else {
					if (_unit in _inListCheck) then {
						_inListCheck = _inListCheck - [_unit];
					};
				};
			};
		};
	};
	if (_zoneLeftUnits >= _minUnits) exitWith {
		_running = false;
		//** MODULE COMPLETION
		_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionEscapeFromZone", _winSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
		_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionEscapeFromZone_1", _zoneLeftUnits, _totalUnits, _areaName]];
		_module setVariable ["a3a_var_module_isCompleted", true];
		//// MODULE COMPLETION
	};

	if (((count _units) + _zoneLeftUnits) < _minUnits) exitWith {
		_running = false;
		//** MODULE COMPLETION
		_side_1 = [] call A3A_fnc_GetBFSide;
		_side_2 = [] call A3A_fnc_GetOFSide;
		_winSide = if (_winSide isEqualTo _side_1) then { _side_2 } else { _side_1 };
		_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionEscapeFromZone", _winSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
		_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionEscapeFromZone_2", _deadUnits, _totalUnits, _areaName]];
		_module setVariable ["a3a_var_module_isCompleted", true];
		//// MODULE COMPLETION
	};
	
	if (_timeToEscape > 0) then {
		if ((diag_tickTime - _timerStarted) > _timeToEscape) exitWith {
			_running = false;
			//** MODULE COMPLETION
			_side_1 = [] call A3A_fnc_GetBFSide;
			_side_2 = [] call A3A_fnc_GetOFSide;
			_winSide = if (_winSide isEqualTo _side_1) then { _side_2 } else { _side_1 };
			_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionEscapeFromZone", _winSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
			_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionEscapeFromZone_3", _areaName]];
			_module setVariable ["a3a_var_module_isCompleted", true];
			//// MODULE COMPLETION
		};
	};
	sleep _random;
};