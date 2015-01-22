private ["_module", "_marker", "_freezeTime", "_side", "_message", "_freezeTime", "_finishTime"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = [_this,1,[],[[]]] call BIS_fnc_param;

////// PARAMETERS //////
_freezeTime = _module getVariable ["Time", nil];
_side = _module getVariable ["Side", nil];
_message = _module getVariable ["Message", nil];

////// CHECK PARAMETERS //////
if (isNil "_freezeTime" || isNil "_side" || isNil "_message") exitWith {
	hint "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE:\nFreeze Vehicles Timer";
	diag_log "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE: Freeze Vehicles Timer";
};

if ((count _units) == 0) exitWith {
	hint "[ATRIUM ERROR]: NO SYNCED UNITS IN MODULE:\nFreeze Vehicles Timer";
	diag_log "[ATRIUM ERROR]: NO SYNCED UNITS IN MODULE: Freeze Vehicles Timer";
};

_freezeTime = _freezeTime * 60;

// Check correct time settings
if ((_freezeTime < 60) && (_freezeTime != 6)) exitWith {
	hint "[ATRIUM ERROR]: WRONG TIME IN MODULE:\nFreeze Vehicles Timer";
	diag_log "[ATRIUM ERROR]: WRONG TIME IN MODULE: Freeze Vehicles Timer";
};

////// DEBUG //////
diag_log format["Freeze vehicles list: %1", _units];
////// DEBUG //////

a3a_var_forceVehiclesFreeze = _units;
publicVariable "a3a_var_forceVehiclesFreeze";

waitUntil {sleep 1.928; !isNil "a3a_var_started"};
waitUntil {sleep 0.328; a3a_var_started};

_finishTime = diag_tickTime + _freezeTime;

while { diag_tickTime < _finishTime } do {
	sleep 2.317;
};

if (_side > -2) then {
	if (_side == -1) then {
		[_message, 0] call a3a_fnc_message;
	} else {
		switch (_side) do {
			case 0: { _side = WEST };
			case 1: { _side = EAST };
			case 2: { _side = RESISTANCE };
		};
		[_message, 0, _side] call a3a_fnc_message;
	};
};

a3a_var_forceVehiclesFreeze = nil;
publicVariable "a3a_var_forceVehiclesFreeze";