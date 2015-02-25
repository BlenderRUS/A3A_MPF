#define MODULE_NAME "End Mission Dead In Zone"
private ["_module", "_units", "_marker", "_areaName", "_minUnits", "_winSide", "_zonePos", "_side_1", "_side_2", "_rectangle", "_direction", "_trigger", "_inListCheck"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;

////// PARAMETERS //////
_marker = _module getVariable ["MarkerName", -64];
_minUnits = _module getVariable ["MinUnits", -64];
_areaName = _module getVariable ["AreaName", -64];

_errors = [MODULE_NAME,
	[
		["MARKER", _marker],
		["UNITS", _units],
		["MIN_MAX", _minUnits, 0, count _units],
		["AREA NAME", _areaName]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

if (_minUnits == 0) then { _minUnits = count _units };

waitUntil { sleep 0.816; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

// Get sides
_side_1 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_side_2 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));

// Marker Shape
_rectangle = if (markerShape _marker == "RECTANGLE") then { true } else { false };
_direction = markerDir _marker;

// Create Trigger
_trigger = createTrigger["EmptyDetector", getMarkerPos _marker];
_trigger setTriggerArea[(markerSize _marker) select 0, (markerSize _marker) select 1, _direction, _rectangle];
_trigger setTriggerActivation["ANY", "PRESENT", false];
_trigger setTriggerStatements["false", "", ""];
_trigger setTriggerTimeout [15, 15, 15, false];

waitUntil { sleep 5.159; _ls = list _trigger; !isNil "_ls" };

_winSide = if (side (group (_units select 0)) == _side_1) then { _side_2 } else { _side_1 };

_fnc_getName = {
	private ["_type", "_name"];
	_type = typeOf _this;
	if (_type isKindOf "Man") then {
		_name = name _this;
		if (_name == "Error: No unit") then { _name = "VIP" };
	} else {
		_name = getText(configFile >> "CfgVehicles" >> _type >> "displayName");
		if (_name == "") then { _name = _type };
	};
	_name
};

diag_log format["[A3A] Dead In Zone: %1 <> %2", _units, _minUnits];

_inListCheck = []; // 2nd check for absent units (getIn/getOut vehicle bug related)

while {true} do {
	_unitsList = (list _trigger) call A3A_fnc_Modules_GetCrewUnits;
	_tempUnits = _units;
	for "_i" from 0 to ((count _tempUnits) - 1) do {
		_unit = _tempUnits select _i;
		if (isNull _unit) then {
			_units = _units - [_unit];
		} else {
			if !(alive _unit) then {
				_units = _units - [_unit];
				_name = _unit call _fnc_getName;
				[["STR_A3A_Modules_isDead", _name], 3] call a3a_fnc_message;
			} else {
				if !(_unit in _unitsList) then {
					if (_unit in _inListCheck) then {
						_units = _units - [_unit];
						_inListCheck = _inListCheck - [_unit];
						_name = _unit call _fnc_getName;
						[["STR_A3A_Modules_leftZone", _name], 1] call a3a_fnc_message;
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
	
	if (count _units < _minUnits) exitWith {
		diag_log format["[A3A] End Mission Dead In Zone: %1 <> %2", _units, _minUnits];
		//** MODULE COMPLETION
		_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionDeadInZone", _winSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
		_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionDeadInZone", _areaName]];
		_module setVariable ["a3a_var_module_isCompleted", true];
		//// MODULE COMPLETION
	};
	sleep 5.863;
};