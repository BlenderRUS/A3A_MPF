// Server bots cleanup

if (isNil "a3a_var_dontRemoveAI") then {
	_units = if (isDedicated) then { playableUnits } else { allUnits };
	{
		_slotName = _x getVariable ["PlayerName", nil];
		if (isNil "_slotName") then {
			deleteVehicle _x;
		};
	} forEach _units;
} else {
	if (!isDedicated) then {
		hint "WARNING!!!\nDisable AI remove module is ACTIVE!";
	};
};