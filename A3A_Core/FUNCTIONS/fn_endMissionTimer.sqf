// End mission timer
// Usage: [Message, Time in seconds, Side which will win when timer ends] spawn a3a_fnc_endMissionTimer;
// Example: ["60 minutes left, NATO wins", 3600, WEST] spawn a3a_fnc_endMissionTimer;
private ["_message", "_time", "_side", "_countStart", "_timeLeft"];

_message = _this select 0;
_time = _this select 1;

if (count _this > 2) then {
	_side = _this select 2;
};

_countStart = diag_tickTime;
while {true} do {
	_timeLeft = _time - diag_tickTime + _countStart;
	if (_timeLeft <= 0) exitWith {
		if (isNil "_side") then {
			[_message] call a3a_fnc_endMission;
		} else {
			[_message, _side] call a3a_fnc_endMission;
		};
	};
	sleep 3.210;
};