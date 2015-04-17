_veh = vehicle player;
if (_veh != player) then {
	if (_veh isKindOf "Air") then {
		if (viewDistance != a3a_var_viewDistance_air) then {
			setViewDistance a3a_var_viewDistance_air
		};
	} else {
		if (_veh isKindOf "LandVehicle") then {
			if (viewDistance != a3a_var_viewDistance_vehicle) then {
				setViewDistance a3a_var_viewDistance_vehicle
			};
		};
	};
} else {
	if (viewDistance != a3a_var_viewDistance_infantry) then {
		setViewDistance a3a_var_viewDistance_infantry
	};
};