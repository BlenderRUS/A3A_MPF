/*
Function: a3a_fnc_endMissionZonesCapture
Author: [SUB7] Blender

Parameters:
1 - Zones (ARRAY)
2 - End mission on timer end (check if attackers got all zones, else attackers failed), or '0' for instant mission end on full zones control (NUMBER)
3 - Change colors on cap (BOOL)
4 - Defenders (SIDE IN *STRING* FORMAT)

Zones parameters:
1 - Marker (STRING)
2 - Zone name to display (STRING)
3 - Minimum number of attackers (NUMBER)
4 - Supremacy coefficient of attackers (NUMBER)
Example:
[[["marker1", "ZONE 1 NAME", 1, 1], ["marker2", "ZONE 2 NAME", 1, 1]], 0, true, "WEST"] spawn a3a_fnc_endMissionZonesCapture;
*/

private ["_zones_array", "_end_mission_on_timer", "_change_colors", "_BFSide", "_OFSide", "_startTime"];

if (!isNil "a3ru_var_countUnitsZones") exitWith { diag_log "ERROR: Count Units Function already started!" };
a3ru_var_captureZones = [];

_zones_array = _this select 0;
_end_mission_on_timer = _this select 1;
_change_colors = _this select 2;
_defenders = _this select 3;
_startTime = diag_tickTime;

_BFSide = "BFSIDE" call A3A_fnc_Modules_GetSettings;
_OFSide = "OFSIDE" call A3A_fnc_Modules_GetSettings;
_BFSide_str = str _BFSide;
_OFSide_str = str _OFSide;

for "_i" from 0 to ((count _zones_array) - 1) do {
	_zone_array = _zones_array select _i;
	_marker = _zone_array select 0; // Zone position (marker name)
	_name = _zone_array select 1;
	_minMan = _zone_array select 2;
	_supremacy_coeff = _zone_array select 3;
	
	_zonePos = getMarkerPos _marker;
	
	_rectangle = false;
	_direction = 0;

	// Marker Shape
	if (typeName _marker == "STRING") then {
		_rectangle = if (markerShape _marker == "RECTANGLE") then { true } else { false };
		_direction = markerDir _marker;
	};
	
	_trigger = createTrigger["EmptyDetector", _zonePos];
	_trigger setTriggerArea[(markerSize _marker) select 0, (markerSize _marker) select 1, _direction, _rectangle];
	_trigger setTriggerActivation["ANY", "PRESENT", false];
	_trigger setTriggerStatements["false", "", ""];
	_trigger setTriggerTimeout [15, 15, 15, false];

	waitUntil { sleep 0.159; _ls = list _trigger; !isNil "_ls" };
	a3ru_var_captureZones SET [count a3ru_var_captureZones, [_trigger, "NEUTRAL", _name, _minMan, _supremacy_coeff, _marker]];
};

while {!a3a_var_missionFinished} do {
	for "_i" from 0 to ((count a3ru_var_captureZones) - 1) do {
		private ["_el", "_trigger", "_control_side", "_name", "_minMan", "_supremacy_coeff", "_marker", "_units", "_BFCount", "_OFCount"];
		_el = a3ru_var_captureZones select _i;
		_trigger = _el select 0;
		_control_side = _el select 1;
		_zone_name = _el select 2;
		_minMan = _el select 3;
		_supremacy_coeff = _el select 4;
		_marker = _el select 5;
		
		_units = list _trigger;
		
		_BFCount = 0;
		_OFCount = 0;
		_neutral = true;
		
		for "_i2" from 0 to ((count _units) - 1) do
		{
			_unit = _units select _i2;
			if (_unit isKindOf "Man") then {
				if (side _unit == _BFSide) then {
					_BFCount = _BFCount + 1;
				};
				if (side _unit == _OFSide) then {
					_OFCount = _OFCount + 1;
				};
			} else {
				if (side _unit == _BFSide) then {
					_BFCount = _BFCount + (count (crew _unit));
				};
				if (side _unit == _OFSide) then {
					_OFCount = _OFCount + (count (crew _unit));
				};
			};
		};

		// BLUEFOR Supremacy
		if (_BFSide_str == _defenders) then {
			if ((_BFCount >= _OFCount) && (_BFCount > 0)) then {
				_neutral = false;
				if (_control_side != _BFSide_str) then {
					_el SET [1, _BFSide_str];
					a3ru_var_captureZones SET [_i, _el];
					if (_change_colors) then {
						_marker setMarkerColor "ColorBlue";
					};
					if (diag_tickTime - _startTime > 10) then {
						// ACTION
						[format[localize "STR_A3RU_ZoneCaptured", _zone_name, localize ("str_" + _BFSide_str)], 0] call a3a_fnc_message;
					};
				};
			};
		} else {
			if ((_BFCount > (_OFCount * _supremacy_coeff)) && (_BFCount >= _minMan)) then {
				_neutral = false;
				if (_control_side != _BFSide_str) then {
					_el SET [1, str(_BFSide)];
					a3ru_var_captureZones SET [_i, _el];
					if (_change_colors) then {
						_marker setMarkerColor "ColorBlue";
					};
					if (diag_tickTime - _startTime > 10) then {
						// ACTION
						[format[localize "STR_A3RU_ZoneCaptured", _zone_name, localize ("str_" + _BFSide_str)], 0] call a3a_fnc_message;
					};
				};
			};
		};
		
		// OPFOR Supremacy
		if (_OFSide_str == _defenders) then {
			if ((_OFCount >= _BFCount) && (_OFCount > 0)) then {
				_neutral = false;
				if (_control_side != _OFSide_str) then {
					_el SET [1, _OFSide_str];
					a3ru_var_captureZones SET [_i, _el];
					if (_change_colors) then {
						_marker setMarkerColor "ColorRed";
					};
					if (diag_tickTime - _startTime > 10) then {
						[format[localize "STR_A3RU_ZoneCaptured", _zone_name, localize ("str_" + _OFSide_str)], 0] call a3a_fnc_message;
					};
				};
			};
		} else {
			if ((_OFCount > (_BFCount * _supremacy_coeff)) && (_OFCount >= _minMan)) then {
				_neutral = false;
				if (_control_side != _OFSide_str) then {
					_el SET [1, _OFSide_str];
					a3ru_var_captureZones SET [_i, _el];
					if (_change_colors) then {
						_marker setMarkerColor "ColorRed";
					};
					if (diag_tickTime - _startTime > 10) then {
						[format[localize "STR_A3RU_ZoneCaptured", _zone_name, localize ("str_" + _OFSide_str)], 0] call a3a_fnc_message;
					};
				};
			};
		};
		
		if (_neutral) then {
			if (_control_side != "NEUTRAL") then {
				_el SET [1, "NEUTRAL"];
				a3ru_var_captureZones SET [_i, _el];
				if (_change_colors) then {
					_marker setMarkerColor "ColorBlack";
				};
				if (diag_tickTime - _startTime > 10) then {
					[format[localize "STR_A3RU_ZoneNeutral", _zone_name], 0] call a3a_fnc_message;
				};
			};
		};

		sleep 0.517;
	};
	if (_end_mission_on_timer == 0) then {
		_zonesCount = count a3ru_var_captureZones;
		_BFCount = 0;
		_OFCount = 0;
		for "_i" from 0 to (_zonesCount - 1) do {
			_el = a3ru_var_captureZones select _i;
			_controlSide = _el select 1;
			if (_controlSide == _BFSide_str && (_BFSide_str != _defenders)) then {
				_BFCount = _BFCount + 1;
			} else {
				if (_controlSide == _OFSide_str && (_OFSide_str != _defenders)) then {
					_OFCount = _OFCount + 1;
				};
			};
		};
		if (_BFCount == _zonesCount) exitWith {
			[format[localize "STR_A3RU_AllZonesCapturedBy", localize ("str_" + _BFSide_str)], _BFSide] call a3a_fnc_endMission;
		};
		if (_OFCount == _zonesCount) exitWith {
			[format[localize "STR_A3RU_AllZonesCapturedBy", localize ("str_" + _OFSide_str)], _OFSide] call a3a_fnc_endMission;
		};
	} else {
		if ((diag_tickTime - _startTime) >= _end_mission_on_timer) exitWith {
			_zonesCount = count a3ru_var_captureZones;
			_countSide = if (_BFSide_str == _defenders) then { [_OFSide_str, _OFSide, _BFSide_str, _BFSide] } else { [_BFSide_str, _BFSide, _OFSide_str, _OFSide] };
			_unitsCount = 0;
			for "_i" from 0 to (_zonesCount - 1) do {
				_el = a3ru_var_captureZones select _i;
				_controlSide = _el select 1;
				if (_controlSide == (_countSide select 0)) then {
					_unitsCount = _unitsCount + 1;
				};
			};
			if (_unitsCount == _zonesCount) then {
				[format[localize "STR_A3RU_AllZonesCapturedBy", localize ("str_" + (_countSide select 0))], (_countSide select 1)] call a3a_fnc_endMission;
			} else {
				[format[localize "STR_A3RU_ZonesDefendedBy", localize ("str_" + (_countSide select 2))], (_countSide select 3)] call a3a_fnc_endMission;
			};
		};
	};
	sleep 7.217;
};