private ["_module", "_BFLoss", "_OFLoss", "_sideSupremacy", "_a3a_lossUnits", "_BFSide", "_OFSide", "_BFStart", "_BFstart", "_BFCount", "_OFCount"];
_module = [_this,0,objNull,[objNull]] call BIS_fnc_param;

////// PARAMETERS //////
_BFLoss = _module getVariable ["BFSideLoss", nil];
_OFLoss = _module getVariable ["OFSideLoss", nil];
_sideSupremacy = _module getVariable ["SideSupremacy", nil];

////// CHECK PARAMETERS //////
if (isNil "_BFLoss" || isNil "_OFLoss" || isNil "_sideSupremacy") exitWith {
	hint "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE:\nCombat Losses";
	diag_log "[ATRIUM ERROR]: WRONG PARAMETERS NUMBER IN MODULE: Combat Losses";
};
if (_OFLoss <= 0 || _OFLoss > 100 || _BFLoss <= 0 || _BFLoss > 100) exitWith {
	hint "[ATRIUM ERROR]: WRONG LOSS COEFFICIENT IN MODULE:\nCombat Losses";
	diag_log "[ATRIUM ERROR]: WRONG LOSS COEFFICIENT IN MODULE: Combat Losses";
};

waitUntil {sleep 3.928; !isNil "a3a_var_started"};
waitUntil {sleep 0.328; a3a_var_started};

if (_sideSupremacy < 0) then { _sideSupremacy = 0 };

// Combat losses
_BFSide = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_OFSide = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));

_a3a_lossUnits = if (isDedicated) then { playableUnits } else { allUnits };
_BFstart = {(alive _x) && (side _x == _BFSide)} count _a3a_lossUnits;
_OFstart = {(alive _x) && (side _x == _OFSide)} count _a3a_lossUnits;

if (_sideSupremacy == 0) then {
	while {true} do {
		_a3a_lossUnits = if (isDedicated) then { playableUnits } else { allUnits };
		_BFCount = {(alive _x) && (side _x == _BFSide)} count _a3a_lossUnits;
		_OFCount = {(alive _x) && (side _x == _OFSide)} count _a3a_lossUnits;
		if (_OFCount < (_OFstart * _OFLoss / 100)) exitWith {
			[format[localize "STR_A3A_heavyLosses", _OFSide, _BFSide], _BFSide] call a3a_fnc_endMission;
		};

		if (_BFCount < (_BFstart * _BFLoss / 100)) exitWith {
			[format[localize "STR_A3A_heavyLosses", _BFSide, _OFSide], _OFSide] call a3a_fnc_endMission;
		};
		sleep 7.326;
	};
} else {
	while {true} do {
		_a3a_lossUnits = if (isDedicated) then { playableUnits } else { allUnits };
		_BFCount = {(alive _x) && (side _x == _BFSide)} count _a3a_lossUnits;
		_OFCount = {(alive _x) && (side _x == _OFSide)} count _a3a_lossUnits;
		if ((_OFCount * _sideSupremacy < _BFCount) || (_OFCount < (_OFstart * _OFLoss / 100))) exitWith {
			[format[localize "STR_A3A_heavyLosses", _OFSide, _BFSide], _BFSide] call a3a_fnc_endMission;
		};

		if ((_BFCount * _sideSupremacy < _OFCount) || (_BFCount < (_BFstart * _BFLoss / 100))) exitWith {
			[format[localize "STR_A3A_heavyLosses", _BFSide, _OFSide], _OFSide] call a3a_fnc_endMission;
		};
		sleep 7.326;
	};
};