// Get Broadcasted Message

if (count _this > 2) then {
	_message = _this select 0;
	_type = _this select 1;
	_side = _this select 2;
	if (side player == _side) then {
		switch (_type) do {
			case 0: { ["TaskSucceeded",[0, _message]] call bis_fnc_showNotification };
			case 1: { ["TaskFailed",[0, _message]] call bis_fnc_showNotification };
			case 2: { ["TaskAssigned",[0, _message]] call bis_fnc_showNotification };
			case 3: { ["TaskCanceled",[0, _message]] call bis_fnc_showNotification };
		};
	};
} else {
	_message = _this select 0;
	_type = _this select 1;
	switch (_type) do {
		case 0: { ["TaskSucceeded",[0, _message]] call bis_fnc_showNotification };
		case 1: { ["TaskFailed",[0, _message]] call bis_fnc_showNotification };
		case 2: { ["TaskAssigned",[0, _message]] call bis_fnc_showNotification };
		case 3: { ["TaskCanceled",[0, _message]] call bis_fnc_showNotification };
	};
};