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
waitUntil {sleep 1.928; !isNil "a3a_var_started"};
waitUntil {sleep 0.328; a3a_var_started};

_countStart = diag_tickTime;
while {true} do {
	_timeLeft = _time - diag_tickTime + _countStart;
	if (_timeLeft <= 0) exitWith {
		[_message, _side] call a3a_fnc_endMission;
	};
	sleep 3.210;
};