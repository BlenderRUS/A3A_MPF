/// START GAME TIMER
/// SHOULD BE INITIALIZED AFTER time > 0
// PVs:
// a3a_var_started - initialized at init
// a3a_var_timeCorrection
// a3a_var_srv_timerSkip
// a3a_var_leadersArray
// a3a_var_srv_voteReady
//// SERVER COUNTER

private ["_units", "_timeToCount", "_timeCountUpdate", "_timeCountStart", "_timeCountStep"];

_BFSide = "bluefor" call a3a_fnc_getSide;
_OFSide = "opfor" call a3a_fnc_getSide;

_BFLeaders = [];
_OFLeaders = [];

_units = if (isMultiplayer) then { playableUnits } else { allUnits };

_allGroups = allGroups;

for "_i" from 0 to ((count _allGroups) - 1) do {
	_group = _allGroups select _i;
	_leader = leader _group;
	if (_leader in _units) then {
		if ((side _group) == _BFSide) then {
			_BFLeaders pushBack _leader;
		} else {
			if ((side _group) == _OFSide) then {
				_OFLeaders pushBack _leader;
			};
		};
	};
};

a3a_var_leadersArray = [_BFLeaders, _OFLeaders];
publicVariable "a3a_var_leadersArray";
//// VOTE START ////

_timeToCount = _this select 0; // Time to count
_timeCountUpdate = 10; // Send timer correction value to clients every XX steps

_timeCountStart = diag_tickTime;
_timeCountStep = 0;

a3a_var_timeCorrection = _timeToCount;
a3a_var_srv_timerSkip = nil;

publicVariable "a3a_var_timeCorrection"; // Send counter variable to clients
if (!isDedicated && !isNil "a3a_fnc_cli_counter") then {
	a3a_var_timeCorrection spawn a3a_fnc_cli_counter;
};

while { !a3a_var_started && isNil "a3a_var_srv_timerSkip" } do {
	a3a_var_timeCorrection = _timeToCount - (diag_tickTime - _timeCountStart);
	if (a3a_var_timeCorrection <= 0 || [] call a3a_fnc_srv_counter_countVote) then {
		a3a_var_srv_timerSkip = true
	} else {
		if ((_timeCountStep >= _timeCountUpdate) && a3a_var_timeCorrection > 10) then {
			_timeCountStep = 0;
			publicVariable "a3a_var_timeCorrection";
			if (!isDedicated && !isNil "a3a_fnc_cli_counter") then {
				a3a_var_timeCorrection spawn a3a_fnc_cli_counter;
			};
		};
		_timeCountStep = _timeCountStep + 1;
		sleep 1.017;
	};
};

if (!a3a_var_started) then {
	a3a_var_started = true;
	publicVariable "a3a_var_started";
};

// Functions/Variables cleanup
if (isDedicated) then {
	a3a_fnc_srv_counter_setVote = nil;
	a3a_fnc_srv_counter_countVote = nil;

	a3a_var_timeCorrection = nil;
	a3a_var_srv_timerSkip = nil;
	a3a_var_leadersArray = nil;
	a3a_var_srv_voteReady = nil;
};