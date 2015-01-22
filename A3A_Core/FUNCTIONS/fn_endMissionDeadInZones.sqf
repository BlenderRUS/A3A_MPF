// a3a_fnc_endMissionDeadInZones
// Checks if units are alive or in zones area. Mission ends if everyone has been killed or left the zones
// [
//   [MARKER1/POS1/OBJ1, SIZE1, OBJECT1],
//   [MARKER2/POS2/OBJ2, SIZE2, OBJECT2]
// ] spawn a3a_fnc_endMissionDeadInZones
// Example: [["mark_1", 0, vip1], ["mark_2", 0, vip2], ["mark_3", 0, vip3]] spawn a3a_fnc_endMissionDeadInZones;

private ["_BFSide", "_OFSide", "_winSide", "_array", "_checkArray"];

_BFSide = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_OFSide = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));

_array = _this;
_checkArray = [];

{
	private ["_zone", "_zoneSize", "_unit", "_unitsInZone", "_zonePos"];
	_zone = _x select 0;
	_zoneSize = _x select 1;
	_unit = _x select 2;
	
	switch toLower(typeName _zone) do {
		case "array": { _zonePos = _zone };
		case "string": { _zonePos = getMarkerPos _zone };
		case "object": { _zonePos = getPos _zone };
		default { hintC "[a3a_fnc_endMissionDeadInZone] Wrong zone parameter!" };
	};
	
	if (_zoneSize == 0 && typeName _zone == "STRING") then {
		_zoneSize = (getMarkerSize _zone) select 0;
	};
	
	switch (side _unit) do {
		case _BFSide: { _winSide = _OFSide };
		case _OFSide: { _winSide = _BFSide };
		default { _winSide = CIVILIAN };
	};
	
	_checkArray SET [count _checkArray, [_zonePos, _zoneSize, _unit, false]];

} forEach _array;

_fnc_getName = {
	private ["_type", "_name"];
	_type = typeOf _this;
	if (_type isKindOf "Man") then {
		_name = name _this;
		if (_name == "Error: No unit") then { _name = "VIP" };
	} else {
		_name = getText(configFile >> "CfgVehicles" >> _type >> "displayName");
		if (_name == "") then { _name = _type };
	};
	_name
};

while {true} do {
	_standingZones = 0;
	{
		private ["_zonePos", "_zoneSize", "_unit", "_failed", "_name", "_remove"];
		_zonePos = _x select 0;
		_zoneSize = _x select 1;
		_unit = _x select 2;
		_failed = _x select 3;
		_remove = false;
		
		if (!(isNull _unit) && !(_failed)) then {
			if (_unit distance _zonePos > _zoneSize) then {
				_name = _unit call _fnc_getName;
				[format["%1 has left mission zone!", _name], 1] call a3a_fnc_message;
				_remove = true;
			};
			if !(alive _unit) then {
				_name = _unit call _fnc_getName;
				[format["%1 is dead!", _name], 3] call a3a_fnc_message;
				_remove = true;
			};
			if (_remove) then {
				_checkArray SET [_forEachIndex, [_zonePos, _zoneSize, _unit, true]];
			} else {
				_standingZones = _standingZones + 1;
			};
		};
	} forEach _checkArray;
	
	if (_standingZones == 0) exitWith {
		[localize "STR_A3RU_targetsKilled2", _winSide] call a3a_fnc_endMission;
	};
	sleep 5.863;
};