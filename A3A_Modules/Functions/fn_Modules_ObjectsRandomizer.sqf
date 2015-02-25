#define MODULE_NAME "Objects Randomizer"
private ["_allModules", "_mods_processed", "_modules_count", "_mod", "_returned", "_mods_list", "_units_list", "_mod_random", "_mod_pos", "_pos1", "_pos2", "_unit", "_relPos", "_errors", "_mirror"];

_allModules = allMissionObjects "A3A_ObjectsRandomizer";

_mods_processed = []; // TEMPORARY VARIABLE FOR COLLECTING MODULES

/// GET ALL SYNCED MODULES FOR SPECIFIED MODULE
_fnc_getAllSynced = {
	private ["_module", "_mods_list", "_mods_units", "_mods_index", "_synced"];
	_module = _this;
	_mods_list = [_module];
	_mods_units = [];
	_mods_index = 0;
	while { count _mods_list > _mods_index } do {
		_synced = synchronizedObjects (_mods_list select _mods_index);
		_mods_units = _mods_units + (_synced call A3A_fnc_Modules_ExcludeModules);
		{
			if (!(_x in _mods_list) && !(_x in _mods_processed) && (_x in _allModules)) then { _mods_list pushBack _x };
		} forEach _synced;
		_mods_index = _mods_index + 1;
	};
	[_mods_list, _mods_units]
};

/// GET ALL MODULES AND UNITS
_modules_count = count _allModules;
for "_i" from 0 to (_modules_count - 1) do {
	_mod = _allModules select _i;
	if !(_mod in _mods_processed) then {
		_returned = _mod call _fnc_getAllSynced;
		_mods_list = _returned select 0;
		_units_list = _returned select 1;
		
		_mods_processed = _mods_processed + _mods_list;
		
		////// CHECK PARAMETERS //////
		_errors = [MODULE_NAME,
			[
				["COUNT_ARRAY", _mods_list, 2],
				["COUNT_ARRAY", _units_list, 1]
			]
		] call A3A_fnc_Modules_CheckConditions;
		if (_errors) exitWith {};

		_mod_random = _mods_list select (floor (random (count _mods_list)));
		_mod_pos = [(getPos _mod_random) select 0, (getPos _mod_random) select 1, 0];
		
		if ((count _units_list) > 0) then {
			_pos1 = getPos (_units_list select 0);

			for "_i" from 0 to ((count _units_list) - 1) do {
				_unit = _units_list select _i;
				_relPos = [0,0];
				if (_i > 0) then {
					_pos2 = getPosATL _unit;
					if (surfaceIsWater _pos2) then {
						_pos2 = getPosASL _unit;
					};
					_relPos = [(_pos1 select 0) - (_pos2 select 0), (_pos1 select 1) - (_pos2 select 1)];
				};
				_spawnPos = [0,0,0];
				_dir = getDir _unit;
				_mirror = _mod_random getVariable ["Mirrored", false];
				if (_mirror) then {
					// SET MIRRORED DIRECTION
					if (_dir >= 180) then {
						_dir = (_dir - 180)
					} else {
						_dir = (_dir + 180)
					};
					// SET MIRRORED POSITION
					_spawnPos = [(_mod_pos select 0) + (_relPos select 0), (_mod_pos select 1) + (_relPos select 1), 0]
				} else {
					_spawnPos = [(_mod_pos select 0) - (_relPos select 0), (_mod_pos select 1) - (_relPos select 1), 0]
				};
				_unit setVariable ["A3A_var_teleportObject", [_dir, _spawnPos], true];
				_unit setDir _dir;
				if (surfaceIsWater _spawnPos) then {
					_unit setPosASL _spawnPos
				} else {
					_unit setPosATL _spawnPos
				};
			};
		};
	};
};

a3a_var_srv_randomized = true;
publicVariable "a3a_var_srv_randomized";