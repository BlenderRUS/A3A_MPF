if (typeName _this != "STRING") exitWith {
	diag_log "A3RU UI Remove error: Not a string";
};

if (isNil "a3a_UI_array") exitWith {
	diag_log "A3RU UI Remove error: Array already is empty!";
};

_found = false;
{
	if (_x select 0 == _this) exitWith {
		a3a_UI_array SET [_forEachIndex, -1];
		a3a_UI_array = a3a_UI_array - [-1];
		_found = true;
	};
} forEach a3a_UI_array;

if !(_found) then {
	diag_log format["A3RU UI Remove error: %1 action not found!", _this];
};