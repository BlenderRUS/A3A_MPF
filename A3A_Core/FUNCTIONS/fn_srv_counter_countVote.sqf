private ["_start", "_playersPresent", "_leaders", "_unit"];
_start = true;
_playersPresent = false;
_leaders = (a3a_var_leadersArray select 0) + (a3a_var_leadersArray select 1);
for "_i" from 0 to ((count _leaders) - 1) do {
	_unit = _leaders select _i;
	if (!isNull _unit) then {
		if (alive _unit && isPlayer _unit) then {
			_playersPresent = true;
			_ready = _unit getVariable ["A3A_Ready", false];
			if (!_ready) exitWith { _start = false };
		};
	};
};
if (_start && !_playersPresent) then {
	_start = false
};
_start