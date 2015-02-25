#define MODULE_NAME "End Mission Dead Units"
private ["_module", "_units", "_marker", "_areaName", "_minUnits", "_winSide", "_zonePos", "_side_1", "_side_2", "_rectangle", "_direction", "_trigger"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;

////// PARAMETERS //////
_minUnits = _module getVariable ["MinUnits", -64];
_winSide = _module getVariable ["WinSide", -64];

// Get sides
_side_1 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_side_2 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));

switch (_winSide) do {
	case 0: { _winSide = WEST };
	case 1: { _winSide = EAST };
	case 2: { _winSide = RESISTANCE };
};

_errors = [MODULE_NAME,
	[
		["UNITS", _units],
		["MIN_MAX", _minUnits, 0, count _units],
		["SIDE_COMP", _winSide]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

if (_minUnits == 0) then { _minUnits = count _units };

_anotherSide = if (_winSide isEqualTo _side_1) then { _side_2 } else { _side_1 };

waitUntil { sleep 0.816; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

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

diag_log format["[A3A] Dead Units: %1 <> %2", _units, _minUnits];

while {true} do {
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
			};
		};
	};
	
	if (count _units < _minUnits) exitWith {
		diag_log format["[A3A] End Mission Dead Units: %1 <> %2", _units, _minUnits];
		//** MODULE COMPLETION
		_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionDeadUnits", _winSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
		_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionDeadUnits", count _units, _minUnits]];
		_module setVariable ["a3a_var_module_isCompleted", true];
		//// MODULE COMPLETION
	};
	sleep 5.863;
};