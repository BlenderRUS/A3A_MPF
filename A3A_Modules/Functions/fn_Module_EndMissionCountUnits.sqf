private ["_module", "_marker", "_side", "_minMan", "_message", "_zonePos", "_side_1", "_side_2", "_rectangle", "_direction", "_trigger"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;

////// PARAMETERS //////
_marker = _module getVariable ["MarkerName", nil];
_side = _module getVariable ["Side", nil];
_minMan = _module getVariable ["MinMan", nil];
_message = _module getVariable ["Message", nil];

////// CHECK PARAMETERS //////
if (isNil "_marker" || isNil "_side" || isNil "_minMan" || isNil "_message") exitWith {
	hint "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE:\nCount Units";
	diag_log "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE: Count Units";
};

if (_minMan < 1) exitWith {
	hint "[ATRIUM ERROR]: WRONG MINIMUM UNITS VALUE IN MODULE:\nCount Units";
	diag_log "[ATRIUM ERROR]: WRONG MINIMUM UNITS VALUE IN MODULE: Count Units";
};

// Check marker
_zonePos = getMarkerPos _marker;
if (_zonePos distance [0,0,0] < 10) exitWith {
	hint "[ATRIUM ERROR]: WRONG MARKER NAME/POSITION IN MODULE:\nCount Units";
	diag_log "[ATRIUM ERROR]: WRONG MARKER NAME/POSITION IN MODULE: Count Units";
};

_fnc_isPlayer =	if (count (allMissionObjects "A3A_DontRemoveAI") > 0) then { { true } } else { { isPlayer _unit } };

switch (_side) do {
	case 0: { _side = WEST };
	case 1: { _side = EAST };
	case 2: { _side = RESISTANCE };
};

waitUntil {sleep 3.928; !isNil "a3a_var_started"};
waitUntil {sleep 0.328; a3a_var_started};

// Get sides
_side_1 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_side_2 = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));

// Marker Shape
_rectangle = if (markerShape _marker == "RECTANGLE") then { true } else { false };
_direction = markerDir _marker;

// Create Trigger
_trigger = createTrigger["EmptyDetector", _zonePos];
_trigger setTriggerArea[(markerSize _marker) select 0, (markerSize _marker) select 1, _direction, _rectangle];
_trigger setTriggerActivation["ANY", "PRESENT", false];
_trigger setTriggerStatements["false", "", ""];
_trigger setTriggerTimeout [15, 15, 15, false];

waitUntil { sleep 0.159; _ls = list _trigger; !isNil "_ls" };

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
	if ((_manCount < _minMan) && _enemyPresence) exitWith {
		_winSide = if (_side == _side_1) then { _side_2 } else { _side_1 };
		[_message, _winSide] call a3a_fnc_endMission;
	};
	sleep 5.213;
};