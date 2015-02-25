#define MODULE_NAME "External File"
private ["_module", "_units", "_moduleName", "_filePath", "_errors", "_var_mod_started"];

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

waitUntil { sleep 0.476; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

/// CALLING ARGUMENTS
// MODULE NAME (STRING)
// SYNCED UNITS (ARRAY)
// START TIME (NUMBER)

[_moduleName, _units, _var_mod_started] execVM _filePath;