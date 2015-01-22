// a3a_fnc_endMission
// a3a_fnc_endMission - ends current mission
// Syntax: [message, win side] or [message]
// Usage: [MESSAGE, EAST] call a3a_fnc_endMission;
// Example: ["All Iranian Troops were killed", WEST] call a3a_fnc_endMission;

_this spawn {
	if (isNil "a3a_var_missionFinished") then { a3a_var_missionFinished = false };
	if (a3a_var_missionFinished) exitWith {};
	a3a_var_missionFinished = true;
	if (typeName _this == "STRING") then { // Old Atrium version End Mission fix
		_this = [_this];
	};
	[_this select 0, 2] call a3a_fnc_message;
	sleep 3;
	if (count _this > 1) then {
		a3a_var_endMission = _this select 1;
		publicVariable "a3a_var_endMission";
		if (!isDedicated) then {
			if (side player == _this select 1) then {
				["end5",true,true] call BIS_fnc_endMission;
			} else {
				["end5",false,true] call BIS_fnc_endMission;
			};
		} else {
			["end5",true,true] call BIS_fnc_endMission;
		};
	} else {
		a3a_var_endMission = "true";
		publicVariable "a3a_var_endMission";
		if (!isDedicated) then {
			["end5",true,true] call BIS_fnc_endMission;
		} else {
			["end5",true,true] call BIS_fnc_endMission;
		};
	};
};