private ["_module", "_units", "_random", "_BFSide", "_OFSide", "_zone", "_area", "_side", "_minMan", "_message", "_zonePos", "_vehCount", "_man", "_veh", "_manCount", "_modules_list"];

_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = synchronizedObjects _module;

////// PARAMETERS //////
_capTime = _module getVariable ["CapTime", nil];
_holdTime = _module getVariable ["HoldTime", nil];
_marker = _module getVariable ["MarkerName", nil];
_areaName = _module getVariable ["AreaName", nil];
_changeColor = _module getVariable ["ChangeMarkerColor", nil];

////// CHECK PARAMETERS //////
if (isNil "_capTime" || isNil "_holdTime" || isNil "_marker" || isNil "_areaName" || isNil "_changeColor") exitWith {
	hint "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE:\nZone Capture";
	diag_log "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE: Zone Capture";
};

if (_changeColor == 0) then { _changeColor = false } else { _changeColor = true };

_capTime = _capTime * 60;
_holdTime = _holdTime * 60;

// Check marker
_zonePos = getMarkerPos _marker;
if (_zonePos distance [0,0,0] < 10) exitWith {
	hint "[ATRIUM ERROR]: WRONG MARKER NAME/POSITION IN MODULE:\nZone Capture";
	diag_log "[ATRIUM ERROR]: WRONG MARKER NAME/POSITION IN MODULE: Zone Capture";
};

// Check correct hold / cap time settings
if ((_holdTime < 60) && (_holdTime != 6) || (_capTime < 60) && (_capTime != 6)) exitWith {
	hint "[ATRIUM ERROR]: WRONG HOLD/CAPTURE TIME IN MODULE:\nZone Capture";
	diag_log "[ATRIUM ERROR]: WRONG HOLD/CAPTURE TIME IN MODULE: Zone Capture";
};

_module setVariable ["zoneStatus", [false, sideUnknown]];

waitUntil {sleep 1.928; !isNil "a3a_var_started"};
waitUntil {sleep 0.328; a3a_var_started};

_random = 4 + (random 1);

_fnc_isPlayer =	if (count (allMissionObjects "A3A_DontRemoveAI") > 0) then { { true } } else { { isPlayer _unit } };

////// ADD SYNCED MODULES //////
_modules_list = [];

{
	private "__finished";
	__finished = _x getVariable ["zoneStatus", nil];
	if !(isNil "__finished") then {
		_modules_list SET [count _modules_list, _x];
	};
} forEach _units;

// Get sides
_side_1 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_side_2 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));

// Marker Shape
_rectangle = if (markerShape _marker == "RECTANGLE") then { true } else { false };
_direction = markerDir _marker;

// Create Trigger
_triggerArea = [(markerSize _marker) select 0, (markerSize _marker) select 1, _direction, _rectangle];
_trigger = createTrigger["EmptyDetector", _zonePos];
_trigger setTriggerArea _triggerArea;
_trigger setTriggerActivation["ANY", "PRESENT", false];
_trigger setTriggerStatements["false", "", ""];
_trigger setTriggerTimeout [15, 15, 15, false];

waitUntil { sleep 0.159; _ls = list _trigger; !isNil "_ls" };

_fnc_getSupremacy = {
	private ["_side_1_count", "_side_2_count", "_unitsInArea", "_unit"];
	_side_1_count = 0;
	_side_2_count = 0;
	_unitsInArea = list _trigger;
	
	for "_i" from 0 to ((count _unitsInArea) - 1) do {
		_unit = _unitsInArea select _i;
		if (alive _unit && call _fnc_isPlayer) then {
			if (side (group _unit) == _side_1) then {
				_side_1_count = _side_1_count + 1;
			} else {
				if (side (group _unit) == _side_2) then {
					_side_2_count = _side_2_count + 1;
				};
			};
		};
	};
	
	if (_side_1_count == 0 && _side_2_count == 0) then {
		-1
	} else {
		if (_side_1_count == _side_2_count) then {
			0
		} else {
			if (_side_1_count > _side_2_count) then {
				1
			} else {
				2
			};
		};
	};
};

_check_finished = {
	if !((_module getVariable "zoneStatus") select 0) then {
		_module setVariable ["zoneStatus", [true, _this]];
		[format[localize "STR_A3A_Modules_DefendedZone", _this, _areaName], 2] call a3a_fnc_message;
	};
	_finish = true;
	{
		__finished = _x getVariable "zoneStatus";
		if !(__finished select 0) exitWith {
			_finish = false;
		};
		if ((__finished select 1) != _this) exitWith {
			_finish = false;
		};
	} forEach _modules_list;
	
	_finish
};

_areaStatus = 0; // 0 - neutral, 1 - captured
_areaControl = 0; // 0 - neutral, 1 - side 1, 2 - side 2
_areaProgress = 0; // 0%-100%
_lastPresenceSide = -1;
_lastPresenceTime = diag_tickTime;
_lastMarkerSide = 0;

while {true} do {
	_supremacy = [] call _fnc_getSupremacy;
	switch (_supremacy) do {
		case -1: {
			if (_lastPresenceSide != -1) then {
				_lastPresenceSide = -1;
			};
			if (_areaStatus == 0) then { // Reset captured progress
				_areaControl = 0;
				_areaProgress = 0;
				if (_changeColor && _lastMarkerSide != 0) then {
					_lastMarkerSide = 0;
					_marker setMarkerColor "ColorGrey";
				};
			};
		};
		case 0: {
			// EQUAL FORCES
			a3a_event_zoneCap = [_trigger, _triggerArea, 0, _areaProgress, _areaStatus, _areaName];
			if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
			publicVariable "a3a_event_zoneCap";
		};
		case 1: {
			if (_areaControl != 2) then { // SAME CONTROL SIDE
				if (_changeColor && _lastMarkerSide != 1) then {
					_lastMarkerSide = 1;
					_marker setMarkerColor "ColorBlue";
				};
				_areaControl = 1;
				if (_lastPresenceSide == 1) then {
					if (_areaStatus == 0) then { // NEUTRAL
						_progress = (diag_tickTime - _lastPresenceTime) * 100 / _capTime;
						if ((_areaProgress + _progress) >= 100) then { // PROCEED TO HOLD
							_areaStatus = 1;
							_areaProgress = 0;
							///
							[format[localize "STR_A3A_capturedZone", _side_1, _areaName], 2] call a3a_fnc_message;
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, 99, 0, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
						} else {
							_areaProgress = _areaProgress + _progress;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
						};
					} else {
						_progress = (diag_tickTime - _lastPresenceTime) * 100 / _holdTime;
						if ((_areaProgress + _progress) >= 100) then {
							_areaProgress = 100;
							// SIDE 1 WINS!
							///
							//[format[localize "STR_A3A_defendedZone", _side_1, _areaName], _side_1] call a3a_fnc_endMission;
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, 99, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							if (_side_1 call _check_finished) exitWith {
								[format[localize "STR_A3A_Modules_DefendedZones", _side_1], _side_1] spawn a3a_fnc_endMission;
							};
							///
						};
						_areaProgress = _areaProgress + _progress;
						///
						a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
						if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
						publicVariable "a3a_event_zoneCap";
						///
					};
				} else {
					_lastPresenceSide = 1;
				};
			} else { // ENEMY CONTROLLED, DEPROGRESS
				if (_lastPresenceSide == 1) then {
					if (_areaStatus == 1) then {
						_progress = (diag_tickTime - _lastPresenceTime) * 100 / _holdTime;
						if ((_areaProgress - _progress) <= 0) then { // PROCEED TO CAPTURE
							_areaStatus = 0;
							_areaControl = 1;
							_areaProgress = 0;
							_module setVariable ["zoneStatus", [false, _side_1]];
							[format[localize "STR_A3A_neutralizedZone", _side_1, _areaName], 2] call a3a_fnc_message;
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, 1, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
						} else {
							_areaProgress = _areaProgress - _progress;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
						};
					} else {
						_areaControl = 1;
						_areaProgress = 0;
					};
				} else {
					_lastPresenceSide = 1;
				};
			};
		};
		case 2: {
			if (_areaControl != 1) then { // SAME CONTROL SIDE
				if (_changeColor && _lastMarkerSide != 2) then {
					_lastMarkerSide = 2;
					_marker setMarkerColor "ColorRed";
				};
				_areaControl = 2;
				if (_lastPresenceSide == 2) then {
					if (_areaStatus == 0) then { // NEUTRAL
						_progress = (diag_tickTime - _lastPresenceTime) * 100 / _capTime;
						if ((_areaProgress + _progress) >= 100) then { // PROCEED TO HOLD
							_areaStatus = 1;
							_areaProgress = 0;
							///
							[format[localize "STR_A3A_capturedZone", _side_2, _areaName], 2] call a3a_fnc_message;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, 99, 0, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
						} else {
							_areaProgress = _areaProgress + _progress;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
						};
					} else {
						_progress = (diag_tickTime - _lastPresenceTime) * 100 / _holdTime;
						if ((_areaProgress + _progress) >= 100) then {
							_areaProgress = 100;
							// SIDE 2 WINS!
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, 99, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							if (_side_2 call _check_finished) exitWith {
								[format[localize "STR_A3A_Modules_DefendedZones", _side_2], _side_2] spawn a3a_fnc_endMission;
							};
							///
						};
						_areaProgress = _areaProgress + _progress;
						///
						a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
						if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
						publicVariable "a3a_event_zoneCap";
						///
					};
				} else {
					_lastPresenceSide = 2;
				};
			} else { // ENEMY CONTROLLED, DEPROGRESS
				if (_lastPresenceSide == 2) then {
					if (_areaStatus == 1) then { // NEUTRAL
						_progress = (diag_tickTime - _lastPresenceTime) * 100 / _holdTime;
						if ((_areaProgress - _progress) <= 0) then { // PROCEED TO CAPTURE
							_areaStatus = 0;
							_areaControl = 2;
							_areaProgress = 0;
							_module setVariable ["zoneStatus", [false, _side_2]];
							///
							[format[localize "STR_A3A_neutralizedZone", _side_2, _areaName], 2] call a3a_fnc_message;
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, 1, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
						} else {
							_areaProgress = _areaProgress - _progress;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_module_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
						};
					} else {
						_areaControl = 2;
						_areaProgress = 0;
					};
				} else {
					_lastPresenceSide = 2;
				};
			};
		};
	};
	_lastPresenceTime = diag_tickTime;
	sleep _random;
};