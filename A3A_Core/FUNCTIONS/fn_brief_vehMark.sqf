private ["_vehiclesText", "_leader", "_leaderPos", "_zoneSize", "_vehPos", "_vehicles", "_picture", "_description", "_marker", "_name"];
if (isNil "a3a_var_brief_vehMarkArray") then { a3a_var_brief_vehMarkArray = [] };
if (isNil "a3a_var_brief_vehArray") then { a3a_var_brief_vehArray = [] };

_vehicles = vehicles - a3a_var_brief_vehArray;

if !(a3a_var_started) then {
	_vehiclesText = "";
	for "_i" from 0 to ((count _this) - 1) do {
		_leader = _this select _i;
		_leaderPos = (_leader getVariable ["A3A_var_teleportObject", [0, getPos _leader]]) select 1;
		_zoneSize = "PREPAREZONESIZE" call A3A_fnc_Modules_GetSettings;
		{
			_vehPos = (_x getVariable ["A3A_var_teleportObject", [0, getPos _x]]) select 1;
			if (((_vehPos distance _leaderPos) <= _zoneSize) && !(_x in a3a_var_brief_vehArray)) then {
				_marker = str(_x);
				createMarkerLocal[_marker, _vehPos];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "mil_dot";
				_name = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
				_picture = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "picture");
				_marker setMarkerTextLocal _name;
				_marker setMarkerColorLocal "ColorYellow";
				a3a_var_brief_vehMarkArray SET [count a3a_var_brief_vehMarkArray, _marker];
				a3a_var_brief_vehArray SET [count a3a_var_brief_vehArray, _x];
				_vehiclesText = _vehiclesText + format["<marker name='%1'>%2</marker><br/>", _marker, _name];
			};
		} forEach _vehicles;
	};
	player createDiaryRecord ["diary", [localize "STR_A3RU_briefVehicles", _vehiclesText ]];
};