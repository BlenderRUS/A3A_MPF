// Slot reservation (Server) by Blender
// For ARMA3.RU

// Array args: object / uid / name
a3a_var_reserved = [];

a3a_fnc_srv_findSlot = {
	private ["_return", "_i", "_this", "_arr"];
	_return = -1;
	for "_i" from 0 to ((count a3a_var_reserved) - 1) do {
		_arr = a3a_var_reserved select _i;
		if (_this == _arr select 0) exitWith {
			_return = [_arr select 0, _arr select 1, _arr select 2];
		};
	};
	_return
};

a3a_fnc_srv_findUID = {
	private ["_return", "_i", "_this", "_arr"];
	_return = -1;
	for "_i" from 0 to ((count a3a_var_reserved) - 1) do {
		_arr = a3a_var_reserved select _i;
		if (_this == _arr select 1) exitWith {
			_return = [_arr select 0, _arr select 1, _arr select 2];
		};
	};
	_return
};

// Passed args: action / object / uid / name
a3a_fnc_srv_checkSlot = {
	private ["_action", "_obj", "_uid", "_name", "_array", "_return"];
	_action = _this select 0;
	_obj = _this select 1;
	_uid = _this select 2;
	_name = _this select 3;
	
	_return = [1];
	
	switch (_action) do {
		case 0: { // Check UID
			if (!isNull _obj) then {
				_array = _obj call a3a_fnc_srv_findSlot;
				if (typeName _array == "ARRAY") then { // Object found
					if (_array select 1 == _uid) then { // Object Match
						_return = [1];
					} else { // Object dismatch
						_return = [2, _array select 2];
					};
				} else { // Object not found
					_array = _uid call a3a_fnc_srv_findUID;
					if (typeName _array != "ARRAY") then {
						_return = [0];
					} else { // Object already present
						_return = [4, _array select 0];
					};
				};
			};
		};
		case 1: {
			_array = _uid call a3a_fnc_srv_findUID;
			if (typeName _array != "ARRAY") then { // Object set
				a3a_var_reserved SET [count a3a_var_reserved, [_obj, _uid, _name]];
				_return = [3];
			} else { // Object already present
				_return = [4, _array select 0];
			};
		};
	};
	a3a_var_cli_reservedSlot = _return;
	(owner _obj) publicVariableClient "a3a_var_cli_reservedSlot";
};

"a3a_var_srv_reservedSlot" addPublicVariableEventHandler { (_this select 1) spawn a3a_fnc_srv_checkSlot };