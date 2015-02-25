#define MODULE_NAME "End Mission External File"
private ["_module", "_units", "_moduleName", "_filePath", "_errors", "_var_mod_started", "_return", "_winSide", "_message"];

_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;

// Get parameters
_moduleName = _module getVariable ["ModuleName", ""];
_filePath = _module getVariable ["FilePath", ""];

_errors = [MODULE_NAME,
	[
		["EMPTY_STRING", _moduleName],
		["EMPTY_STRING", _filePath]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

waitUntil { sleep 0.483; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

/// CALLING ARGUMENTS
// MODULE NAME (STRING)
// SYNCED UNITS (ARRAY)
// START TIME (NUMBER)

/// RETURN PARAMETERS
// WIN SIDE (SIDE)
// MESSAGE (STRING)
// EXAMPLE: [WEST, "ALL UNITS HAS BEEN KILLED"]
// EXAMPLE 2: [WEST, ""]

_return = [_moduleName, _units, _var_mod_started] call compile preprocessFileLineNumbers _filePath;

if (count _return != 2) exitWith {
	hint format["[MODULE ERROR]\nNAME: %1\nWRONG RETURN PARAMETERS NUMBER", _moduleName];
};

_winSide = _return select 0;
_message = _return select 1;

_errors = [MODULE_NAME,
	[
		["SIDE_COMP", _winSide]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

//** MODULE COMPLETION
_module setVariable ["a3a_var_module_stats", [[_moduleName], _winSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
if (_message != "") then {
	_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_DummyMessage", _message]];
};
_module setVariable ["a3a_var_module_isCompleted", true];
//// MODULE COMPLETION