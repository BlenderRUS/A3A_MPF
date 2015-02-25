#define MODULE_NAME "End Mission Capture"
private ["_running", "_module", "_random", "_BFSide", "_OFSide", "_zone", "_area", "_side", "_minMan", "_message", "_zonePos", "_vehCount", "_man", "_veh", "_manCount", "_modules_list", "_captureSide", "_triggerSides"];

_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;

////// PARAMETERS //////
_capTime = _module getVariable ["CapTime", -64];
_holdTime = _module getVariable ["HoldTime", -64];
_marker = _module getVariable ["MarkerName", -64];
_areaName = _module getVariable ["AreaName", -64];
_changeColor = _module getVariable ["ChangeMarkerColor", -64];
_captureSide = _module getVariable ["CaptureSide", 0]; // 0 - everyone, 1 - west, 2 - east, 3 - resistance

////// CHECK PARAMETERS //////
_errors = [MODULE_NAME,
	[
		["MARKER", _marker],
		["MIN_MAX", _capTime, 0],
		["MIN_MAX", _holdTime, 0],
		["AREA NAME", _areaName],
		["CHANGE COLOR", _changeColor]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

_triggerSides = [WEST, EAST, RESISTANCE];
switch (_captureSide) do {
	case 1: { _triggerSides = [WEST] };
	case 2: { _triggerSides = [EAST] };
	case 3: { _triggerSides = [RESISTANCE] };
};

if (_changeColor == 0) then { _changeColor = false } else { _changeColor = true };

_capTime = _capTime * 60;
_holdTime = _holdTime * 60;

waitUntil { sleep 0.816; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

_random = 4 + (random 1);

_dontRemoveAI = (count (allMissionObjects "A3A_DontRemoveAI")) > 0;

_fnc_isPlayer =	if (_dontRemoveAI) then { { true } } else { { isPlayer _unit } };

// Get sides
_side_1 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_side_2 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));

// Marker Shape
_rectangle = if (markerShape _marker == "RECTANGLE") then { true } else { false };
_direction = markerDir _marker;

// Create Trigger
_triggerArea = [(markerSize _marker) select 0, (markerSize _marker) select 1, _direction, _rectangle];
_trigger = createTrigger["EmptyDetector", getMarkerPos _marker];
_trigger setTriggerArea _triggerArea;
_trigger setTriggerActivation["ANY", "PRESENT", false];
_trigger setTriggerStatements["false", "", ""];
_trigger setTriggerTimeout [15, 15, 15, false];

waitUntil { sleep 0.159; _ls = list _trigger; !isNil "_ls" };

_fnc_getSupremacy = {
	private ["_side_1_count", "_side_2_count", "_unitsInArea", "_unit"];
	_side_1_count = 0;
	_side_2_count = 0;
	_unitsInArea = (list _trigger) call A3A_fnc_Modules_GetCrewUnits;
	
	for "_i" from 0 to ((count _unitsInArea) - 1) do {
		_unit = _unitsInArea select _i;
		if (alive _unit && call _fnc_isPlayer) then {
			_unitSide = side (group _unit);
			if ((_unitSide == _side_1) && (_side_1 in _triggerSides)) then {
				_side_1_count = _side_1_count + 1;
			} else {
				if ((_unitSide == _side_2) && (_side_2 in _triggerSides)) then {
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

_areaStatus = 0; // 0 - neutral, 1 - captured
_areaControl = 0; // 0 - neutral, 1 - side 1, 2 - side 2
_areaProgress = 0; // 0%-100%
_lastPresenceSide = -1;
_lastPresenceTime = diag_tickTime;
_lastMarkerSide = 0;

_running = true;

while {_running} do {
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
			if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
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
							[["STR_A3A_Modules_CapturedZone", _side_1, _areaName], 2] call a3a_fnc_message;
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, 99, 0, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
							if (_holdTime == 0) exitWith {
								_running = false;
								//** MODULE COMPLETION
								_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionCapture", _side_1, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
								_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionCapture", _side_1, _areaName]];
								_module setVariable ["a3a_var_module_isCompleted", true];
								//// MODULE COMPLETION

								_marker setMarkerAlpha 0.3;
								deleteVehicle _trigger;
							};
						} else {
							_areaProgress = _areaProgress + _progress;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
						};
					} else {
						_progress = (diag_tickTime - _lastPresenceTime) * 100 / _holdTime;
						if ((_areaProgress + _progress) >= 100) exitWith {
							_running = false;
							_areaProgress = 100;
							// SIDE 1 WINS!
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, 99, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							[["STR_A3A_Modules_DefendedZone", _side_1, _areaName], 2] call a3a_fnc_message;
							
							//** MODULE COMPLETION
							_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionCapture", _side_1, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
							_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionCapture", _side_1, _areaName]];
							_module setVariable ["a3a_var_module_isCompleted", true];
							//// MODULE COMPLETION

							_marker setMarkerAlpha 0.3;
							deleteVehicle _trigger;
						};
						_areaProgress = _areaProgress + _progress;
						///
						a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
						if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
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
							[["STR_A3A_neutralizedZone", _side_1, _areaName], 2] call a3a_fnc_message;
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, 1, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
						} else {
							_areaProgress = _areaProgress - _progress;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
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
							[["STR_A3A_Modules_CapturedZone", _side_2, _areaName], 2] call a3a_fnc_message;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, 99, 0, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							if (_holdTime == 0) exitWith {
								_running = false;
								//** MODULE COMPLETION
								_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionCapture", _side_2, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
								_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionCapture", _side_2, _areaName]];
								_module setVariable ["a3a_var_module_isCompleted", true];
								//// MODULE COMPLETION

								_marker setMarkerAlpha 0.3;
								deleteVehicle _trigger;
							};
						} else {
							_areaProgress = _areaProgress + _progress;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
						};
					} else {
						_progress = (diag_tickTime - _lastPresenceTime) * 100 / _holdTime;
						if ((_areaProgress + _progress) >= 100) exitWith {
							_running = false;
							_areaProgress = 100;
							// SIDE 2 WINS!
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, 100, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							[["STR_A3A_Modules_DefendedZone", _side_2, _areaName], 2] call a3a_fnc_message;
							
							//** MODULE COMPLETION
							_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionCapture", _side_2, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
							_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_EndMissionCapture", _side_2, _areaName]];
							_module setVariable ["a3a_var_module_isCompleted", true];
							//// MODULE COMPLETION

							_marker setMarkerAlpha 0.3;
							deleteVehicle _trigger;
						};
						_areaProgress = _areaProgress + _progress;
						a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
						if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
						publicVariable "a3a_event_zoneCap";
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
							///
							[["STR_A3A_Modules_NeutralizedZone", _side_2, _areaName], 2] call a3a_fnc_message;
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, 1, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
							publicVariable "a3a_event_zoneCap";
							///
						} else {
							_areaProgress = _areaProgress - _progress;
							///
							a3a_event_zoneCap = [_trigger, _triggerArea, _areaControl, _areaProgress, _areaStatus, _areaName];
							if (!isDedicated) then { [] spawn a3a_fnc_modules_ZoneCaptureVisual };
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