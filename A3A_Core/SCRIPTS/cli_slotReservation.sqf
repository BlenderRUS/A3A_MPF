a3a_fnc_cli_res_startCount = {
	private "_time";
	_time = 180;
	sleep _time;
	//if (isServer) then {
		//[1, player, getPlayerUID player, name player] spawn fnc_srv_checkSlot
	//} else {
		a3a_var_srv_reservedSlot = [1, player, getPlayerUID player, name player];
		publicVariableServer "a3a_var_srv_reservedSlot";
	//};
};

a3a_fnc_cli_res_checkSlot = {
	private "_action";
	_action = _this select 0;
	switch (_action) do {
		case 0: { // Not found
			[] call a3a_fnc_cli_res_startCount;
		};
		case 1: { // Match
			
		};
		case 2: { // Dismatch
			titleText [format[localize "STR_A3RU_slotUsed", _this select 1], "BLACK OUT"];
			hint format[localize "STR_A3RU_slotUsed", _this select 1];
			sleep 10;
			["loser",false,0] call BIS_fnc_endMission;
		};
		case 3: { // Set
			titleText [localize "STR_A3RU_slotReserved", "PLAIN DOWN"];
			hint localize "STR_A3RU_slotReserved";
		};
		case 4: { // Present
			titleText [format[localize "STR_A3RU_alreadyReserved", _this select 1], "BLACK OUT"];
			hint format[localize "STR_A3RU_alreadyReserved", _this select 1];
			sleep 10;
			["loser",false,2] call BIS_fnc_endMission;
		};
	};
};

"a3a_var_cli_reservedSlot" addPublicVariableEventHandler { (_this select 1) spawn a3a_fnc_cli_res_checkSlot };

//if (isServer) then {
	//[0, player, getPlayerUID player, name player] spawn fnc_srv_checkSlot
//} else {
	a3a_var_srv_reservedSlot = [0, player, getPlayerUID player, name player];
	publicVariableServer "a3a_var_srv_reservedSlot";
//};