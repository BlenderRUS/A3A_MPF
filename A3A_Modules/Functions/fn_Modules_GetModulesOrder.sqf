_processed_modules = []; // MODULES/ORDER VARIABLE TO STORE INTO GLOBAL VARIABLE
_mods_processed = []; // TEMPORARY VARIABLE FOR COLLECTING MODULES

/// GET ALL SYNCED MODULES FOR SPECIFIED MODULE
_fnc_getAllSynced = {
	private ["_module", "_mods_list", "_mods_index", "_synced"];
	_module = _this;
	_mods_list = [_module];
	_mods_index = 0;
	while { count _mods_list > _mods_index } do {
		_synced = synchronizedObjects (_mods_list select _mods_index);
		{
			if (!(_x in _mods_list) && !(_x in _mods_processed) && (_x in a3a_var_srv_allModules)) then { _mods_list pushBack _x };
		} forEach _synced;
		_mods_index = _mods_index + 1;
	};
	_mods_list
};

/// SORT MODULES ARRAY BY ORDER VALUE
_fnc_sort = {
	private ["_return", "_mod_count", "_mod_processed", "_index", "_mod_array", "_mod_order"];
	_return = [];
	_mod_count = count _this;
	_mod_processed = 0;
	_index = 0;
	while { _mod_processed < _mod_count } do {
		_currentIndexArray = [];
		for "_i" from 0 to (_mod_count - 1) do {
			_mod_array = _this select _i;
			_mod_order = _mod_array select 0;
			_mod_name = _mod_array select 1;
			
			if (_mod_order == _index) then {
				_currentIndexArray pushBack _mod_name;
				_mod_processed = _mod_processed + 1;
			};
		};
		if (count _currentIndexArray > 0) then {
			_return pushBack _currentIndexArray;
		};
		_index = _index + 1;
	};
	_return
};

/// GET ALL MODULES AND STORE IN ORDER TO VALUE
_modules_count = count a3a_var_srv_allModules;
for "_i" from 0 to (_modules_count - 1) do {
	_module = a3a_var_srv_allModules select _i;
	if !(_module in _mods_processed) then {
		_mods_list = _module call _fnc_getAllSynced;
		_mods_processed = _mods_processed + _mods_list;
		for "_i2" from 0 to ((count _mods_list) - 1) do {
			_mod_to_order = _mods_list select _i2;
			_mod_order = _mod_to_order getVariable ["Order", 0];
			_mods_list SET [_i2, [_mod_order, _mod_to_order]];
		};
		_processed_modules pushBack (_mods_list call _fnc_sort);
	};
};

a3a_var_modules_order = _processed_modules;