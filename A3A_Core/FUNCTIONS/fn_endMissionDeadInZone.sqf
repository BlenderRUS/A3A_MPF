// End mission when units are dead in zone
// Usage: [Pos or Marker or Object, Area size, Area Name, Array of Units, Minimum number of units or 0 if everyone should be in zone] spawn a3a_fnc_endMissionDeadInZone;
// Example: ["mark_port", 0, "West Port", [vip1, vip2], 1] spawn a3a_fnc_endMissionDeadInZone;
// Example: [[1520, 1321, 5], 150, "West Port", [vip1], 0] spawn a3a_fnc_endMissionDeadInZone;

private ["_BFSide", "_OFSide", "_zone", "_area", "_area_name", "_units", "_unitsInZone", "_winSide", "_zonePos", "_inZone", "_action", "_name"];

_BFSide = "BFSIDE" call A3A_fnc_Modules_GetSettings;
_OFSide = "OFSIDE" call A3A_fnc_Modules_GetSettings;

_zone = _this select 0;
_area = _this select 1; 
_area_name = _this select 2;
_units = _this select 3;
_unitsInZone = _this select 4;

if (_unitsInZone == 0) then { _unitsInZone = (count _units) };
switch (side (_units select 0)) do {
	case _BFSide: { _winSide = _OFSide };
	case _OFSide: { _winSide = _BFSide };
	default { _winSide = CIVILIAN };
};

switch toLower(typeName _zone) do {
	case "array": { _zonePos = _zone };
	case "string": { _zonePos = getMarkerPos _zone };
	case "object": { _zonePos = getPos _zone };
	default { hintC "[a3a_fnc_endMissionDeadInZone] Wrong zone parameter!" };
};

if (_area == 0 && typeName _zone == "STRING") then {
	_area = (getMarkerSize _zone) select 0;
};

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
	_inZone = 0;
	{
		if (isNull _x) then {
			_units = _units - [_x];
		} else {
			_remove = false;
			if (_x distance _zonePos > _area) then {
				_name = _x call _fnc_getName;
				[format[localize "STR_A3RU_leftZone", _name], 1] call a3a_fnc_message;
				_remove = true;
			};
			if !(alive _x) then {
				_name = _x call _fnc_getName;
				[format[localize "STR_A3RU_isDead", _name], 3] call a3a_fnc_message;
				_remove = true;
			};
			if (_remove) then {
				_units = _units - [_x];
			} else {
				_inZone = _inZone + 1;
			};
		};
	} forEach _units;
	if (_inZone < _unitsInZone) exitWith {
		[format[localize "STR_A3RU_targetsKilled", _area_name], _winSide] call a3a_fnc_endMission;
	};
	sleep 5.863;
};