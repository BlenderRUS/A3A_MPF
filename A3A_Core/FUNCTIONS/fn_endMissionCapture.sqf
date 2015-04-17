// End Mission: Count units in area
// Written by [SUB7]Blender
// Parameters:
// [<Position or Marker Name>, <zone radius or if you are using marker - type 0 for use the size of marker>, <TRIGGER SIDE>, <MINIMUM UNITS IN ZONE>, <END MISSION MESSAGE>]
// Example:
// I have a marker with a name "mark_port" and BLUEFOR should defend this site with a minimum 3 soldiers presented in area.
// ["mark_port", 0, WEST, 3, "BLUEFOR failed to defend the port"] spawn a3a_fnc_endMissionCountUnits;
// I used zone radius - 0 because the size of the marker already has been defined by in editor
// If you want to make for example vehicle defence mission you can use something like that:
// [getPos myVehicle, 25, EAST, 5, "Vehicle defenders failed"] spawn a3a_fnc_endMissionCountUnits;

private ["_BFSide", "_OFSide", "_zone", "_area", "_side", "_minMan", "_message", "_zonePos", "_vehCount", "_man", "_veh", "_manCount"];

_BFSide = "BFSIDE" call A3A_fnc_Modules_GetSettings;
_OFSide = "OFSIDE" call A3A_fnc_Modules_GetSettings;

_zone = _this select 0;
_area = _this select 1; 
_capTime = _this select 2;
_holdTime = _this select 3;
_area_name = _this select 4;

if (typeName _zone == "ARRAY") then {
	_zonePos = _zone;
} else {
	_zonePos = getMarkerPos _zone;
};
if (_area == 0 && typeName _zone == "STRING") then {
	_area = (getMarkerSize _zone) select 0;
};

// 0 - neutral, 1 - west, 2 - east
_controlSide = 0;
_holdSide = 0;
_capSide = 0;

_controlProgress = 0;
_holdProgress = 0;

fnc_a3ru_pub_pb = {
	if (isNil "a3ru_pub_pb_var") then { a3ru_pub_pb_var = _this };
	if (((_this select 0) != (a3ru_pub_pb_var select 0)) || ((_this select 1) != (a3ru_pub_pb_var select 1))) then {
		a3ru_zoneCap = _this;
		publicVariable "a3ru_zoneCap";
		if !(isDedicated) then {
			a3ru_zoneCap spawn a3a_fnc_pb_visual;
		};
	};
};

_updateTime = 3;
_lastControlStart = diag_tickTime;
_controlStart = 0;
_holdStart = diag_tickTime;
_exit = false;

while {true} do {
	_vehWestCount = 0;
	_vehEastCount = 0;
	_man = [];
	{ if ((getPosASL _x) select 2 > -1) then { _man SET [count _man, _x] } } forEach (_zonePos nearEntities [["Man"], _area]);
	_veh = _zonePos nearEntities [["LandVehicle"], _area];
	_manWestCount = _BFSide countSide _man;
	_manEastCount = _OFSide countSide _man;
	{
		if (side _x == _BFSide) then {
			_vehWestCount = _vehWestCount + (count (crew _x));
		};
		if (side _x == _OFSide) then {
			_vehEastCount = _vehEastCount + (count (crew _x));
		};
	} forEach _veh;
	
	_manWestCount = _manWestCount + _vehWestCount;
	_manEastCount = _manEastCount + _vehEastCount;

	if (_manWestCount > 0 || _manEastCount > 0) then {
		// BLUEFOR Supremacy
		if (_manWestCount > _manEastCount) then {
			if (_holdSide != 1) then {
				_holdSide = 0;
				_holdProgress = 0;
				_timeWasted = diag_tickTime - _lastControlStart;
				_capTimeBlock = _capTime / 10;
				
				if (_timeWasted > _capTimeBlock) then {
					_lastControlStart = diag_tickTime;
					if (_controlSide == 1) then {
						_controlProgress = _controlProgress + round(_timeWasted / _capTimeBlock);
						if (_controlProgress > 9) then {
							_holdSide = 1;
							[format[localize "STR_A3RU_capturedZone", _BFSide, _area_name], 2] call a3a_fnc_message;
							_holdStart = diag_tickTime;
							[0, 10, _zonePos, _area] call fnc_a3ru_pub_pb;
						} else {
							[0, _controlProgress, _zonePos, _area] call fnc_a3ru_pub_pb;
						};
					} else {
						_controlProgress = _controlProgress - round(_timeWasted / _capTimeBlock);
						if (_controlProgress < 1) then {
							if (_controlSide != 0) then {
								[format[localize "STR_A3RU_neutralizedZone", _BFSide, _area_name], 2] call a3a_fnc_message;
							};
							_controlSide = 1;
							[0, 0, _zonePos, _area] call fnc_a3ru_pub_pb;
						} else {
							[7, _controlProgress, _zonePos, _area] call fnc_a3ru_pub_pb;
						};
					};
				};
			} else {
				if (diag_tickTime - _holdStart > _holdTime) exitWith {
					switch (_holdSide) do {
						//default { format["%1 Defended!", _area_name] call a3a_fnc_endMission };
						case 1: { [format[localize "STR_A3RU_defendedZone", _BFSide, _area_name], _BFSide] call a3a_fnc_endMission };
						case 2: { [format[localize "STR_A3RU_defendedZone", _OFSide, _area_name], _OFSide] call a3a_fnc_endMission };
					};
					_exit = true;
				};

				_holdTimeWasted = diag_tickTime - _holdStart;
				_holdTimeBlock = _holdTime / 10;
				if (_holdTimeWasted > _holdTimeBlock * _holdProgress) then {
					_holdProgress = _holdProgress + 1;//round(_holdTimeWasted / _holdTimeBlock);
				};
				[5, _holdProgress, _zonePos, _area] call fnc_a3ru_pub_pb;
			};
		};
		
		// OPFOR Supremacy
		if (_manEastCount > _manWestCount) then {
			if (_holdSide != 2) then {
				_holdSide = 0;
				_holdProgress = 0;
				_timeWasted = diag_tickTime - _lastControlStart;
				_capTimeBlock = _capTime / 10;
				if (_timeWasted > _capTimeBlock) then {
					_lastControlStart = diag_tickTime;
					if (_controlSide == 2) then {
						_controlProgress = _controlProgress + round(_timeWasted / _capTimeBlock);
						if (_controlProgress > 9) then {
							_holdSide = 2;
							[format[localize "STR_A3RU_capturedZone", _OFSide, _area_name], 2] call a3a_fnc_message;
							_holdStart = diag_tickTime;
							[1, 10, _zonePos, _area] call fnc_a3ru_pub_pb;
						} else {
							[1, _controlProgress, _zonePos, _area] call fnc_a3ru_pub_pb;
						};
					} else {
						_controlProgress = _controlProgress - round(_timeWasted / _capTimeBlock);
						if (_controlProgress < 1) then {
							if (_controlSide != 0) then {
								[format[localize "STR_A3RU_neutralizedZone", _OFSide, _area_name], 2] call a3a_fnc_message;
							};
							_controlSide = 2;
							[1, 0, _zonePos, _area] call fnc_a3ru_pub_pb;
						} else {
							[8, _controlProgress, _zonePos, _area] call fnc_a3ru_pub_pb;
						};
					};
				};
			} else {
				if (diag_tickTime - _holdStart > _holdTime) exitWith {
					switch (_holdSide) do {
						//default { format["%1 Defended!", _area_name] call a3a_fnc_endMission };
						case 1: { [format[localize "STR_A3RU_defendedZone", _BFSide, _area_name], _BFSide] call a3a_fnc_endMission };
						case 2: { [format[localize "STR_A3RU_defendedZone", _OFSide, _area_name], _OFSide] call a3a_fnc_endMission };
					};
					_exit = true;
				};

				_holdTimeWasted = diag_tickTime - _holdStart;
				_holdTimeBlock = _holdTime / 10;
				if (_holdTimeWasted > _holdTimeBlock * _holdProgress) then {
					_holdProgress = _holdProgress + 1;
				};
				[6, _holdProgress, _zonePos, _area] call fnc_a3ru_pub_pb;
			};
		};
		
		if (_manEastCount == _manWestCount) then {
			_holdStart = diag_tickTime;
			_holdProgress = 0;
			_lastControlStart = diag_tickTime;
			switch (_controlSide) do {
				case 1: { [2, _controlProgress, _zonePos, _area] call fnc_a3ru_pub_pb };
				case 2: { [3, _controlProgress, _zonePos, _area] call fnc_a3ru_pub_pb };
				default { [4, _controlProgress, _zonePos, _area] call fnc_a3ru_pub_pb };
			};
		};
	} else {
		_lastControlStart = diag_tickTime;
		_holdStart = diag_tickTime;
		_holdProgress = 0;
	};
	if (_exit) exitWith {};
	sleep _updateTime;
};