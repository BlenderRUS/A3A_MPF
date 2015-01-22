private ["_unit", "_unitReady", "_leaders", "_isReady"];
_unit = _this select 0;
_unitReady = _this select 1;
_leaders = (a3a_var_leadersArray select 0) + (a3a_var_leadersArray select 1);
if (_unit in _leaders) then {
	_isReady = _unit getVariable ["A3A_Ready", false];
	if !(_unitReady isEqualTo _isReady) then {
		_unit setVariable ["A3A_Ready", _unitReady, true];
	};
};