while {alive player} do {
	_players = allDeadMen;
	for "_i" from 0 to ((count _players) - 1) do {
		_player = _players select _i;
		if (player distance _player < 50 && (_player == vehicle _player)) then {
			_actionAdded = _player getVariable ["A3RU_TagAction", false];
			if !(_actionAdded) then {
				_player setVariable ["A3RU_TagAction", true, false];
				_player addAction ["<img image='\A3A_Core\RESOURCES\a3a_dogTag_icon.paa'/> <t color='#06ef00'>" + localize "STR_A3RU_getDogTag" + "</t>", { (_this select 0) call a3a_fnc_cli_getDogTag}, [], 10, false, false, "", "true"];
			};
		};
		sleep 0.01;
	};
	sleep 6.127;
};