private ["_module", "_units", "_marker", "_areaName", "_minUnits", "_winSide", "_zonePos", "_side_1", "_side_2", "_rectangle", "_direction", "_trigger"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = synchronizedObjects _module; //[_this,1,[],[[]]] call BIS_fnc_param;

////// PARAMETERS //////
_marker = _module getVariable ["MarkerName", nil];
_minUnits = _module getVariable ["MinUnits", nil];
_areaName = _module getVariable ["AreaName", nil];

////// CHECK PARAMETERS //////
if (isNil "_marker" || isNil "_minUnits" || isNil "_areaName") exitWith {
	hint "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE:\nDead In Zone";
	diag_log "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE: Dead In Zone";
};

if ((count _units) == 0) exitWith {
	hint "[ATRIUM ERROR]: NO SYNCED UNITS IN MODULE:\nDead In Zone";
	diag_log "[ATRIUM ERROR]: NO SYNCED UNITS IN MODULE: Dead In Zone";
};

if (_minUnits == 0) then { _minUnits = count _units };

if ((_minUnits < 0) || (_minUnits > (count _units))) exitWith {
	hint "[ATRIUM ERROR]: WRONG MINIMUM UNITS VALUE IN MODULE:\nDead In Zone";
	diag_log "[ATRIUM ERROR]: WRONG MINIMUM UNITS VALUE IN MODULE: Dead In Zone";
};

// Check marker
_zonePos = getMarkerPos _marker;
if (_zonePos distance [0,0,0] < 10) exitWith {
	hint "[ATRIUM ERROR]: WRONG MARKER NAME/POSITION IN MODULE:\nDead In Zone";
	diag_log "[ATRIUM ERROR]: WRONG MARKER NAME/POSITION IN MODULE: Dead In Zone";
};

waitUntil {sleep 1.928; !isNil "a3a_var_started"};
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

waitUntil { sleep 5.159; _ls = list _trigger; !isNil "_ls" };

_winSide = if (side (group (_units select 0)) == _side_1) then { _side_2 } else { _side_1 };

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

diag_log format["[A3A] Dead In Zone: %1 <> %2", _units, _minUnits];

while {true} do {
	_unitsList = list _trigger;
	for "_i" from 0 to ((count _unitsList) - 1) do {
		_obj = _unitsList select _i;
		if ((_obj isKindOf "LandVehicle") || (_obj isKindOf "Air") || (_obj isKindOf "Ship")) then {
			_unitsList = _unitsList + (crew _obj);
		};
	};
	_tempUnits = _units;
	for "_i" from 0 to ((count _tempUnits) - 1) do {
		_unit = _tempUnits select _i;
		if (isNull _unit) then {
			_units = _units - [_unit];
		} else {
			if !(alive _unit) then {
				_units = _units - [_unit];
				_name = _unit call _fnc_getName;
				[format[localize "STR_A3A_isDead", _name], 3] call a3a_fnc_message;
			} else {
				if !(_unit in _unitsList) then {
					_units = _units - [_unit];
					_name = _unit call _fnc_getName;
					[format[localize "STR_A3A_leftZone", _name], 1] call a3a_fnc_message;
				};
			};
		};
	};
	
	if (count _units < _minUnits) exitWith {
		diag_log format["[A3A] End Mission Dead In Zone: %1 <> %2", _units, _minUnits];
		[format[localize "STR_A3A_targetsKilled", _areaName], _winSide] call a3a_fnc_endMission;
	};
	sleep 5.863;
};