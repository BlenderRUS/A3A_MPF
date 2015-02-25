#define MODULE_NAME "No Freeze Vehicles"
private ["_module", "_units"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;

_errors = [MODULE_NAME,
	[
		["UNITS", _units]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

a3a_var_noFreezeVehicles = _units;