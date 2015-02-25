#define MODULE_NAME "End Mission Timer"
private ["_module", "_units", "_time", "_side", "_message", "_countStart", "_timeLeft"];

_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = [_this,1,[],[[]]] call BIS_fnc_param;

// Get parameters
_time = _module getVariable "Time";
_message = _module getVariable "Message";

switch (_module getVariable "Side") do {
	case 0: { _side = WEST };
	case 1: { _side = EAST };
	case 2: { _side = RESISTANCE };
};

// End mission timer
// Usage: [Message, Time in seconds, Side which will win when timer ends] spawn a3a_fnc_endMissionTimer;
// Example: ["60 minutes left, NATO wins", 3600, WEST] spawn a3a_fnc_endMissionTimer;
waitUntil { sleep 0.483; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

_countStart = diag_tickTime;
while {true} do {
	_timeLeft = _time - diag_tickTime + _countStart;
	if (_timeLeft <= 0) exitWith {
		//** MODULE COMPLETION
		_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionTimer", _side, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
		_module setVariable ["a3a_var_module_isCompleted", true];
		//// MODULE COMPLETION
	};
	sleep 3.210;
};