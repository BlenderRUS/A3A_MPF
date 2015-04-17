private ["_startPos", "_markerSize"];

_startPos = player getVariable ["StartPos", nil];
_markerSize = "PREPAREZONESIZE" call A3A_fnc_Modules_GetSettings;
if (!isNil "_startPos") then {
	while {alive player && !a3a_var_started} do {
		private "_distance";
		_distance = player distance _startPos;
		if (_distance >= (_markerSize + 20)) then {
			if (vehicle player != player) then {
				(vehicle player) setVelocity [0,0,0];
				moveOut player;
			};
			player setPos _startPos;
			_distance = player distance _startPos;
			titleText [localize "STR_A3RU_teleBack", "PLAIN"];
		};
		if (_distance >= _markerSize) then {
			titleText [localize "STR_A3RU_leavingZone", "PLAIN"];
		};
		sleep 1;
	};
};