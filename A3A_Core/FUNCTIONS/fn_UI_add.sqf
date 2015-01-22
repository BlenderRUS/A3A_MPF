// Atrium UI action add
// Function: a3a_fnc_ui_add
// Usage: [Action Name, arguments, function to call, condition] call a3a_fnc_ui_add;
// Example: ["Test Action", "player", "fnc_test_function", "alive player"] call a3a_fnc_ui_add;
// Maximum number of actions now limited to 8

if (typeName _this != "ARRAY") exitWith {
	diag_log "A3RU UI Add error: Not array";
};
if (count _this != 4) exitWith {
	diag_log format["A3RU UI Add error: Too much or not enough parameters (%1)", _this];
};

a3a_UI_array SET [count a3a_UI_array, _this];