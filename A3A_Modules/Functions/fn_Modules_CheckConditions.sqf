private ["_module", "_conditions", "_errorsFound", "_finalString", "_condition", "_zonePos", "_side_1", "_side_2", "_side", "_value", "_minValue", "_maxValue", "_error", "_units"];
_module = _this select 0;
_conditions = _this select 1;

_errorsFound = false;

_finalString = format["<font color='#00ff00'>%1</font><br/>", _module];

for "_i" from 0 to ((count _conditions) - 1) do {
	_condition = _conditions select _i;
	switch (toUpper (_condition select 0)) do {
		case "COUNT_SIDES": {
			_finalString = _finalString + "<font color='#0000ff'>SIDE UNITS COUNT </font>";
			_units = if (isDedicated) then { playableUnits } else { allUnits };
			_side_1 = "BFSIDE" call A3A_fnc_Modules_GetSettings;
			_side_2 = "OFSIDE" call A3A_fnc_Modules_GetSettings;
			
			if (({ (side _x) == _side_1 } count _units) == 0) then {
				_finalString = _finalString + "<font color='#ff0000'>ERROR, NO UNITS FOR *BLUEFOR* SIDE FOUND ON MAP!</font><br/>";
				_errorsFound = true;
			};
			if (({ (side _x) == _side_2 } count _units) == 0) then {
				_finalString = _finalString + "<font color='#ff0000'>ERROR, NO UNITS FOR *OPFOR* SIDE FOUND ON MAP!</font><br/>";
				_errorsFound = true;
			};
			if (!_errorsFound) then {
				_finalString = _finalString + format["<font color='#00ff00'>FOUND UNITS FOR EACH SIDE</font><br/>"];
			};
		};
		case "MARKER": {
			_finalString = _finalString + "<font color='#0000ff'>MARKER </font>";
			if (typeName (_condition select 1) == "STRING") then {
				_zonePos = getMarkerPos (_condition select 1);
				if (_zonePos distance [0,0,0] < 10) then {
					_finalString = _finalString + "<font color='#ff0000'>ERROR</font><br/>";
					_errorsFound = true;
				} else {
					_finalString = _finalString + "<font color='#00ff00'>OK</font><br/>";
				};
			} else {
				_finalString = _finalString + "<font color='#ff0000'>ERROR, NOT STRING</font><br/>";
				_errorsFound = true;
			};
		};
		case "UNITS": {
			_finalString = _finalString + "<font color='#0000ff'>UNITS </font>";
			if ((typeName (_condition select 1)) == "ARRAY") then {
				if (count (_condition select 1) <= 0) then {
					_finalString = _finalString + "<font color='#ff0000'>ERROR, SYNCED NO UNITS</font><br/>";
					_errorsFound = true;
				} else {
					_finalString = _finalString + format["<font color='#00ff00'>%1 UNITS</font><br/>", count (_condition select 1)];
				};
			} else {
				_finalString = _finalString + "<font color='#ff0000'>ERROR, NOT ARRAY</font><br/>";
				_errorsFound = true;
			};
		};
		case "SIDE_COMP": {
			_finalString = _finalString + "<font color='#0000ff'>SIDE COMPARE </font>";
			_side = _condition select 1;
			if ((typeName _side) == "SIDE") then {
				_side_1 = "BFSIDE" call A3A_fnc_Modules_GetSettings;
				_side_2 = "OFSIDE" call A3A_fnc_Modules_GetSettings;
				if ((_side != _side_1) && (_side != _side_2)) then {
					_finalString = _finalString + "<font color='#ff0000'>ERROR, SIDE DOESNT EXIST IN MISSION_PARAMETERS.HPP</font><br/>";
					_errorsFound = true;
				} else {
					_finalString = _finalString + "<font color='#00ff00'>OK</font><br/>";
				};
			} else {
				_finalString = _finalString + "<font color='#ff0000'>ERROR, NOT SIDE TYPE</font><br/>";
				_errorsFound = true;
			};
		};
		case "MIN_MAX": {
			_finalString = _finalString + "<font color='#0000ff'>MIN MAX VALUE </font>";
			_value = _condition select 1;
			_minValue = _condition select 2;
			_error = false;
			if (typeName _value == "SCALAR") then {
				if (_value < _minValue) then {
					_error = true;
					_finalString = _finalString + format["<font color='#ff0000'>Value %1 less than %2</font><br/>", _value, _minValue];
					_errorsFound = true;
				};
				if ((count _condition) > 3) then {
					_maxValue = _condition select 3;
					if (_value > _maxValue) then {
						_error = true;
						_finalString = _finalString + format["<font color='#ff0000'>Value %1 is bigger than %2</font><br/>", _value, _maxValue];
						_errorsFound = true;
					};
				};
				if (!_error) then {
					_finalString = _finalString + "<font color='#00ff00'>OK</font><br/>";
				};
			} else {
				_finalString = _finalString + format["<font color='#ff0000'>ERROR, NOT NUMBER!</font><br/>", _value, _maxValue];
				_errorsFound = true;
			};
		};
		case "EMPTY_STRING": {
			_finalString = _finalString + "<font color='#0000ff'>EMPTY STRING </font>";
			if ((_condition select 1) == "") then {
				_finalString = _finalString + "<font color='#ff0000'>ERROR, STRING IS EMPTY</font><br/>";
				_errorsFound = true;
			} else {
				_finalString = _finalString + "<font color='#00ff00'>OK</font><br/>";
			};
		};
		case "COUNT_ARRAY": {
			_finalString = _finalString + "<font color='#0000ff'>ARRAY COUNT </font>";
			_array = _condition select 1;
			_minElements = _condition select 2;
			if (typeName _array == "ARRAY") then {
				if (count _array < _minElements) then {
					_finalString = _finalString + format["<font color='#ff0000'>ERROR, %1 ELEMENTS FOUND, MINIMUM %2 NEEDED</font><br/>", count _array, _minElements];
					_errorsFound = true;
				} else {
					_finalString = _finalString + "<font color='#00ff00'>OK</font><br/>";
				};
			} else {
				_finalString = _finalString + "<font color='#ff0000'>ERROR, NOT AN ARRAY</font><br/>";
				_errorsFound = true;
			};
		};
		default {
			_finalString = _finalString + format["<font color='#0000ff'>%1 </font>", _condition select 0];
			if (typeName (_condition select 1) == "SCALAR") then {
				if ((_condition select 1) == -64) then {
					_finalString = _finalString + "<font color='#ff0000'>NIL VALUE</font><br/>";
					_errorsFound = true;
				} else {
					_finalString = _finalString + "<font color='#00ff00'>NOT NIL</font><br/>";
				};
			} else {
				_finalString = _finalString + "<font color='#00ff00'>NOT NIL</font><br/>";
			};
		};
	};
};

if (!isMultiplayer) then {
	player createDiaryRecord ["diary", ["Modules CHECK", _finalString]];
	if (_errorsFound) then {
		"Module ERRORS" hintC ["Found errors in modules", "Check mission diary!"];
	};
};
_errorsFound