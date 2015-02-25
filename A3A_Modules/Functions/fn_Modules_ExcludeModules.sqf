private ["_units", "_mod_unit"];

_units = [];
for "_i" from 0 to ((count _this) - 1) do {
	_mod_unit = _this select _i;
	if !(_mod_unit isKindOf "Module_F") then {
		_units pushBack _mod_unit;
	};
};
_units