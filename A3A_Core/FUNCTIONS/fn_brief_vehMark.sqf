private ["_vehiclesText", "_leader", "_zoneSize", "_vehicles", "_picture", "_description", "_marker", "_name"];
if (isNil "a3a_var_brief_vehMarkArray") then { a3a_var_brief_vehMarkArray = [] };
if (isNil "a3a_var_brief_vehArray") then { a3a_var_brief_vehArray = [] };

if !(a3a_var_started) then {
	_vehiclesText = "";
	for "_i" from 0 to ((count _this) - 1) do {
		_leader = _this select _i;
		_zoneSize = getNumber (MissionConfigFile >> "A3A_MissionParams" >> "prepareZoneSize");
		_vehicles = (getPos _leader) nearEntities [["LandVehicle", "Air", "Ship"], _zoneSize];
		_vehicles = _vehicles - a3a_var_brief_vehArray;

		if (!isNil "_vehicles") then {
			{
				_marker = str(_x);
				createMarkerLocal[_marker, getPos _x];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "mil_dot";
				_name = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
				_picture = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "picture");
				_marker setMarkerTextLocal _name;
				_marker setMarkerColorLocal "ColorYellow";
				a3a_var_brief_vehMarkArray SET [count a3a_var_brief_vehMarkArray, _marker];
				a3a_var_brief_vehArray SET [count a3a_var_brief_vehArray, _x];
				_vehiclesText = _vehiclesText + format["<marker name='%1'>%2</marker><br/>", _marker, _name];
			} forEach _vehicles;
		};
	};
	player createDiaryRecord ["diary", [localize "STR_A3RU_briefVehicles", _vehiclesText ]];
};