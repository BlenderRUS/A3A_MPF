// Set Mission Startup Parameters

a3a_param_time = paramsArray select 0;
a3a_param_fog = paramsArray select 1;
a3a_param_preTime = paramsArray select 2;
a3a_param_slotReservation = paramsArray select 3;
if ((paramsArray select 4) == 1) then {
	A3RU_SPEC_var_allSides = true
};
a3a_param_externalAddons = paramsArray select 5;

if (time < 600) then {
	switch (a3a_param_time) do {
		default {};
		case 1: {
			setDate [date select 0, date select 1, date select 2, 4, 00];
		};
		case 2: {
			setDate [date select 0, date select 1, date select 2, 6, 00];
		};
		case 3: {
			setDate [date select 0, date select 1, date select 2, 8, 00];
		};
		case 4: {
			setDate [date select 0, date select 1, date select 2, 10, 00];
		};
		case 5: {
			setDate [date select 0, date select 1, date select 2, 11, 00];
		};
		case 6: {
			setDate [date select 0, date select 1, date select 2, 13, 00];
		};
		case 7: {
			setDate [date select 0, date select 1, date select 2, 15, 00];
		};
		case 8: {
			setDate [date select 0, date select 1, date select 2, 17, 00];
		};
		case 9: {
			setDate [date select 0, date select 1, date select 2, 19, 00];
		};
		case 10: {
			setDate [date select 0, date select 1, date select 2, 21, 00];
		};
		case 11: {
			setDate [date select 0, date select 1, date select 2, 23, 00];
		};
		case 12: {
			setDate [date select 0, date select 1, date select 2, 01, 00];
		};
		case 13: {
			setDate [date select 0, date select 1, date select 2, 02, 00];
		};
	};
};

switch (a3a_param_fog) do {
	default {};
	case 1: { 0 setFog [0.3, 0.2, 20] };
	case 2: { 0 setFog [0.5, 0.05, 50] };
	case 3: { 0 setFog [0.1, 0.05, 100] };
	case 4: { 0 setFog [0.01, 0.01, 500]; };
};