#define MODULE_NAME "Lock Vehicles Timer"
private ["_module", "_marker", "_lockTime", "_side", "_message", "_finishTime"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = (synchronizedObjects _module) call A3A_fnc_Modules_ExcludeModules;

////// PARAMETERS //////
_lockTime = _module getVariable ["Time", -64];
_side = _module getVariable ["Side", -64];
_message = _module getVariable ["Message", -64];

_errors = [MODULE_NAME,
	[
		["MIN_MAX", _lockTime, 0],
		["UNITS", _units],
		["MESSAGE", _message],
		["SIDE", _side]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

_lockTime = _lockTime * 60;

////// DEBUG //////
diag_log format["Lock vehicles list: %1", _units];
////// DEBUG //////

for "_i" from 0 to ((count _units) - 1) do {
	_unit = _units select _i;
	_unit lock 2;
};

waitUntil { sleep 0.816; _module getVariable ["a3a_var_module_canProcess", false] };

_finishTime = diag_tickTime + _lockTime;

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

for "_i" from 0 to ((count _units) - 1) do {
	_unit = _units select _i;
	_unit lock 0;
};