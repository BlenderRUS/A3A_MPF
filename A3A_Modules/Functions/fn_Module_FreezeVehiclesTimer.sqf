#define MODULE_NAME "Freeze Vehicles Timer"

private ["_module", "_marker", "_freezeTime", "_side", "_message", "_freezeTime", "_finishTime"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
//_units = [_this,1,[],[[]]] call BIS_fnc_param;
_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;

////// PARAMETERS //////
_freezeTime = _module getVariable ["Time", -64];
_side = _module getVariable ["Side", -64];
_message = _module getVariable ["Message", -64];

_errors = [MODULE_NAME,
	[
		["MIN_MAX", _freezeTime, 0],
		["UNITS", _units],
		["MESSAGE", _message]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

_freezeTime = _freezeTime * 60;

////// DEBUG //////
diag_log format["Freeze vehicles list: %1", _units];
////// DEBUG //////

if (isNil "a3a_var_forceVehiclesFreeze") then {
	a3a_var_forceVehiclesFreeze = _units;
} else {
	a3a_var_forceVehiclesFreeze = a3a_var_forceVehiclesFreeze + _units;
};

publicVariable "a3a_var_forceVehiclesFreeze";

waitUntil { sleep 0.816; _module getVariable ["a3a_var_module_canProcess", false] };

_finishTime = diag_tickTime + _freezeTime;

while { diag_tickTime < _finishTime } do {
	sleep 2.317;
};

if (_side > -2) then {
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

a3a_var_forceVehiclesFreeze = a3a_var_forceVehiclesFreeze - _units;
publicVariable "a3a_var_forceVehiclesFreeze";