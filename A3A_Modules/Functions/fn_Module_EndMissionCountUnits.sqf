#define MODULE_NAME "End Mission Count Units"
private ["_module", "_marker", "_side", "_minMan", "_message", "_zonePos", "_side_1", "_side_2", "_rectangle", "_direction", "_trigger", "_checkVar"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;

////// PARAMETERS //////
_marker = _module getVariable ["MarkerName", -64];
_side = _module getVariable ["Side", -64];
_minMan = _module getVariable ["MinMan", -64];
_message = _module getVariable ["Message", -64];

switch (_side) do {
	case 0: { _side = WEST };
	case 1: { _side = EAST };
	case 2: { _side = RESISTANCE };
};

_errors = [MODULE_NAME,
	[
		["MARKER", _marker],
		["MIN_MAX", _minMan, 1],
		["MESSAGE", _message],
		["SIDE_COMP", _side]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

_fnc_isPlayer =	if (count (allMissionObjects "A3A_DontRemoveAI") > 0) then { { true } } else { { isPlayer _unit } };

waitUntil { sleep 0.816; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

// Get sides
_side_1 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_side_2 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));

// Marker Shape
_rectangle = if (markerShape _marker == "RECTANGLE") then { true } else { false };
_direction = markerDir _marker;

// Create Trigger
_trigger = createTrigger["EmptyDetector", getMarkerPos _marker];
_trigger setTriggerArea[(markerSize _marker) select 0, (markerSize _marker) select 1, _direction, _rectangle];
_trigger setTriggerActivation["ANY", "PRESENT", false];
_trigger setTriggerStatements["false", "", ""];
_trigger setTriggerTimeout [15, 15, 15, false];

waitUntil { sleep 0.159; _ls = list _trigger; !isNil "_ls" };

_checkVar = 0; // 2nd check (getIn/getOut vehicle bug related) 0 - false, 1 - finish, 2 - finished

while {true} do {
	private ["_unitsList", "_manCount", "_enemyPresence", "_winSide"];
	_unitsList = list _trigger;
	_manCount = 0;
	_enemyPresence = false;
	for "_i" from 0 to ((count _unitsList) - 1) do {
		_unit = _unitsList select _i;
		if (alive _unit && call _fnc_isPlayer) then {
			if (side (group _unit) == _side) then {
				if (_unit isKindOf "LandVehicle") then {
					_manCount = _manCount + (count (crew _unit));
				} else {
					_manCount = _manCount + 1;
				};
			} else {
				_enemyPresence = true;
			};
		};
	};
	if ((_manCount < _minMan) && _enemyPresence) then {
		if (_checkVar == 1) then {
			_checkVar = 2;
			_winSide = if (_side == _side_1) then { _side_2 } else { _side_1 };
			
			// MODULE COMPLETION
			_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_EndMissionCountUnits", _winSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
			if (_message != "") then {
				_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_DummyMessage", _message]];
			};
			_module setVariable ["a3a_var_module_isCompleted", true];
		} else {
			_checkVar = 1;
		};
	} else {
		_checkVar = 0;
	};
	if (_checkVar == 2) exitWith {};
	sleep 5.213;
};