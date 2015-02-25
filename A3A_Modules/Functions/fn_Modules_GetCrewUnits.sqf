private ["_unitsList", "_return", "_this", "_obj", "_pos"];

_unitsList = + _this;
_return = [];
for "_i" from 0 to ((count _unitsList) - 1) do {
	_obj = _unitsList select _i;
	_pos = position _obj;
	if (surfaceIsWater _pos) then {
		_pos = (getPosASL _obj) select 2;
	} else {
		_pos = (getPosATL _obj) select 2;
	};
	if ((_pos < 50) && (_pos > -10)) then {
		_return pushBack _obj;
		if ((_obj isKindOf "LandVehicle") || (_obj isKindOf "Air") || (_obj isKindOf "Ship")) then {
			_return = _return + (crew _obj);
		};
	};
};
_return