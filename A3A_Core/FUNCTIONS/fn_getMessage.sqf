// Get Broadcasted Message
private ["_message", "_var1", "_var2", "_var3", "_var4", "_var5", "_arg", "_type", "_side"];

_message = _this select 0;

if (typeName _message == "ARRAY") then {
	_var1 = "";
	_var2 = "";
	_var3 = "";
	_var4 = "";
	_var5 = "";
	
	for "_i" from 1 to ((count _message) - 1) do {
		_arg = _message select _i;
		call compile format["_var%1 = '%2'", _i, _arg];
	};
	
	_message = format[localize (_message select 0), _var1, _var2, _var3, _var4, _var5];
};

if (count _this > 2) then {
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
	_type = _this select 1;
	switch (_type) do {
		case 0: { ["TaskSucceeded",[0, _message]] call bis_fnc_showNotification };
		case 1: { ["TaskFailed",[0, _message]] call bis_fnc_showNotification };
		case 2: { ["TaskAssigned",[0, _message]] call bis_fnc_showNotification };
		case 3: { ["TaskCanceled",[0, _message]] call bis_fnc_showNotification };
	};
};