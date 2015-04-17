#define MODULE_NAME "Combat Losses"

private ["_module", "_BFLoss", "_OFLoss", "_sideSupremacy", "_a3a_lossUnits", "_BFSide", "_OFSide", "_BFStart", "_BFstart", "_BFCount", "_OFCount"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;

////// PARAMETERS //////
_BFLoss = _module getVariable ["BFSideLoss", -64];
_OFLoss = _module getVariable ["OFSideLoss", -64];
_sideSupremacy = _module getVariable ["SideSupremacy", -64];

////// CHECK PARAMETERS //////
_errors = [MODULE_NAME,
	[
		["MIN_MAX", _OFLoss, 1, 100],
		["MIN_MAX", _BFLoss, 1, 100],
		["SIDE SUPREMACY", _sideSupremacy]
	]
] call A3A_fnc_Modules_CheckConditions;
if (_errors) exitWith {};

waitUntil { sleep 1.311; _module getVariable ["a3a_var_module_canProcess", false] };
_var_mod_started = call a3a_fnc_srv_getMissionTime;

if (_sideSupremacy < 0) then { _sideSupremacy = 0 };

// Combat losses
_BFSide = "BFSIDE" call A3A_fnc_Modules_GetSettings;
_OFSide = "OFSIDE" call A3A_fnc_Modules_GetSettings;

_a3a_lossUnits = if (isDedicated) then { playableUnits } else { allUnits };
_BFstart = {(alive _x) && (side _x == _BFSide)} count _a3a_lossUnits;
_OFstart = {(alive _x) && (side _x == _OFSide)} count _a3a_lossUnits;

while {true} do {
	_a3a_lossUnits = if (isDedicated) then { playableUnits } else { allUnits };
	_BFCount = {(alive _x) && (side _x == _BFSide)} count _a3a_lossUnits;
	_OFCount = {(alive _x) && (side _x == _OFSide)} count _a3a_lossUnits;
	if ((_OFCount < (_OFstart * _OFLoss / 100)) || (_OFCount == 0)) exitWith {
		// MODULE COMPLETION
		_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_CombatLosses", _BFSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
		_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_CombatLosses_1", _OFSide, _OFCount, _OFstart]];
		_module setVariable ["a3a_var_module_isCompleted", true];
	};
	
	if ((_BFCount < (_BFstart * _BFLoss / 100)) || (_BFCount == 0)) exitWith {
		// MODULE COMPLETION
		_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_CombatLosses", _OFSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
		_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_CombatLosses_1", _BFSide, _BFCount, _BFstart]];
		_module setVariable ["a3a_var_module_isCompleted", true];
	};

	if (_sideSupremacy != 0) then {
		if ((_OFCount * _sideSupremacy) < _BFCount) exitWith {
			// MODULE COMPLETION
			_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_CombatLosses", _BFSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
			_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_CombatLosses_2", _BFSide, _sideSupremacy, _OFSide]];
			_module setVariable ["a3a_var_module_isCompleted", true];
		};

		if ((_BFCount * _sideSupremacy) < _OFCount) exitWith {
			// MODULE COMPLETION
			_module setVariable ["a3a_var_module_stats", ["STR_A3A_Modules_CombatLosses", _OFSide, _var_mod_started, call a3a_fnc_srv_getMissionTime]];
			_module setVariable ["a3a_var_module_message", ["STR_A3A_Modules_EM_CombatLosses_2", _OFSide, _sideSupremacy, _BFSide]];
			_module setVariable ["a3a_var_module_isCompleted", true];
		};
	};
	sleep 7.326;
};