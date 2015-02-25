private ["_array", "_s_dir", "_s_pos"];
_array = player getVariable ["A3A_var_teleportObject", nil];
if (!isNil "_array") then {
	_s_dir = _array select 0;
	_s_pos = _array select 1;
	player setDir _s_dir;
	if (surfaceIsWater _s_pos) then {
		player setPosASL _s_pos
	} else {
		player setPosATL _s_pos
	};
	player setVariable ["A3A_var_teleportObject", nil, true];
};