_units = [_this,1,[],[[]]] call BIS_fnc_param;

if (count _units == 0) exitWith {
	hint "[ATRIUM ERROR]: NO SYNCED OBJECTS IN MODULE:\nNo Freeze Vehicles";
	diag_log "[ATRIUM ERROR]: NO SYNCED OBJECTS IN MODULE: No Freeze Vehicles";
};

a3a_var_noFreezeVehicles = _units;