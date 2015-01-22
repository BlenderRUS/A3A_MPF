private ["_array", "_marker"];
if (isNil "a3a_var_briefGroupsArray") then { a3a_var_briefGroupsArray = [] };

_array = [];
for "_it" from 0 to ((count allGroups) - 1) do {
	private "_grp";
	_grp = allGroups select _it;
	if (side (leader _grp) == playerSide) then {
		_array SET [count _array, _grp];
	};
};

if (!isNil "_array") then {
	private "_leaders";
	_leaders = [];
	for "_i" from 0 to ((count _array) - 1) do
	{
		private ["_group", "_marker"];
		_group = _array select ((count _array) - 1) - _i;
		_marker = str(_group);
		createMarkerLocal[_marker, getPos (leader _group)];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerTextLocal _marker;
		_marker setMarkerColorLocal "ColorOrange";
		a3a_var_briefGroupsArray SET [count a3a_var_briefGroupsArray, _marker];
		_leaders SET [count _leaders, leader _group];
	};
	_array call a3a_fnc_brief_addGroups;
	_leaders call a3a_fnc_brief_vehMark; // Mark vehicles near group leaders
};