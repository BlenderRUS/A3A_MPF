// Show Message: Count units in area
// Written by [SUB7]Blender
// Parameters:
// [<Position or Marker Name>, <zone radius or if you are using marker - type 0 for use the size of marker>, <TRIGGER SIDE>, <MINIMUM UNITS IN ZONE>, <MESSAGE>]
// Example:
// I have a marker with a name "mark_port" and BLUEFOR should defend this site with a minimum 3 soldiers presented in area.
// ["mark_port", 0, WEST, 3, "No Bluefor soldiers left in Port"] spawn a3a_fnc_showMessageCountUnits;
// I used zone radius - 0 because the size of the marker already has been defined by in editor
// If you want to make for example vehicle defence mission you can use something like that:
// [getPos myVehicle, 25, EAST, 5, "No Vehicle defenders left"] spawn a3a_fnc_endMissionCountUnits;

private ["_BFSide", "_OFSide", "_zone", "_area", "_side", "_minMan", "_message", "_zonePos", "_vehCount", "_man", "_veh", "_manCount"];

_BFSide = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_OFSide = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));

_zone = _this select 0;
_area = _this select 1;
_side = _this select 2;
_minMan = _this select 3;
_message = _this select 4;

if (typeName _zone == "ARRAY") then {
	_zonePos = _zone;
} else {
	_zonePos = getMarkerPos _zone;
};
if (_area == 0 && typeName _zone == "STRING") then {
	_area = (getMarkerSize _zone) select 0;
};

while {true} do {
	_vehCount = 0;
	_man = _zonePos nearEntities [["Man"], _area];
	_veh = _zonePos nearEntities [["LandVehicle"], _area];
	_manCount = _side countSide _man;
	{
		if (side _x == _side) then {
			_vehCount = _vehCount + (count (crew _x));
		};		
	} forEach _veh;
	if ((_manCount + _vehCount) < _minMan) exitWith {
		_winSide = _BFSide;
		if (_side == _BFSide) then { _winSide = _OFSide };
		[_message, 3] call a3a_fnc_message;
	};
	sleep 5.213;
};