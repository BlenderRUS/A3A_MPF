#define MODULE_NAME "VIP In Zone"
private ["_module", "_units", "_marker", "_minUnits", "_side", "_winSide", "_side_1", "_side_2", "_anotherSide", "_var_mod_started", "_rectangle", "_direction", "_trigger"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;

////// PARAMETERS //////
_marker = _module getVariable ["MarkerName", -64];
_minUnits = _module getVariable ["MinUnits", -64];
_side = _module getVariable ["Side", -64];
_winSide = _module getVariable ["WinSide", -64];

// Get sides
_side_1 = "BFSIDE" call A3A_fnc_Modules_GetSettings;
_side_2 = "OFSIDE" call A3A_fnc_Modules_GetSettings;

switch (_winSide) do {
	case 0: { _winSide = WEST };
	case 1: { _winSide = EAST };
	case 2: { _winSide = RESISTANCE };
};

////// CHECK PARAMETERS //////
_errors = [MODULE_NAME,
	[
		["MARKER", _marker],
		["MIN_MAX", _minUnits, 1, count _units],
		["UNITS", _units],
		["SIDE_COMP", _winSide],
		["SIDE", _side]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

_anotherSide = if (_winSide isEqualTo _side_1) then { _side_2 } else { _side_1 };

waitUntil { sleep 0.816; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

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

_delivered = 0;

while {true} do {
	_unitsList = (list _trigger) call A3A_fnc_Modules_GetCrewUnits;
	
	/// REMOVE DELIVERED UNITS FROM ARRAY
	_tempUnits = [];
	for "_i" from 0 to ((count _units) - 1) do {
		_unit = _units select _i;
		if (_unit in _unitsList) then {
			_tempUnits pushBack _unit;
			_delivered = _delivered + 1;
			//// MESSAGE
			if (_side > -2) then {
				_message = ["STR_A3A_Modules_EndMissionVipInZone_Delivered", _unit call _fnc_getName, _delivered, _minUnits];
				if (_side == -1) then {
					[_message, 0] call a3a_fnc_message;
				} else {
					switch (_side) do {
						case 0: { _side = WEST };
						case 1: { _side = EAST };
						case 2: { _side = RESISTANCE };
					};
					[_message, 0, _side] call a3a_fnc_message;
				};
			};
			/// MESSAGE
		} else {
			if (!alive _unit) then {
				_tempUnits pushBack _unit;
				//// MESSAGE
				if (_side > -2) then {
					_message = ["STR_A3A_Modules_EndMissionVipInZone_Dead", _unit call _fnc_getName];
					if (_side == -1) then {
						[_message, 0] call a3a_fnc_message;
					} else {
						switch (_side) do {
							case 0: { _side = WEST };
							case 1: { _side = EAST };
							case 2: { _side = RESISTANCE };
						};
						[_message, 0, _side] call a3a_fnc_message;
					};
				};
				//// MESSAGE
			};
		};
	};
	_units = _units - _tempUnits;
	
	/// CHECK DELIVERED UNITS
	if (_delivered >= _minUnits) exitWith {
		//** MODULE COMPLETION
		_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionVipInZone", _winSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
		_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionVipInZone_1", _delivered, _minUnits]];
		_module setVariable ["a3a_var_module_isCompleted", true];
		//// MODULE COMPLETION
	};
	
	/// CHECK MINIMUM UNITS ALIVE
	if (((count _units) + _delivered) < _minUnits) exitWith {
		//** MODULE COMPLETION
		_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionVipInZone", _anotherSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
		_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionVipInZone_2", _delivered, _minUnits]];
		_module setVariable ["a3a_var_module_isCompleted", true];
		//// MODULE COMPLETION
	};
	sleep 5.863;
};