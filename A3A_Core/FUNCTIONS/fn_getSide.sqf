private "_side";
switch (toLower _this) do {
	default { _side = WEST };
	case "bluefor": {
		_side = "BFSIDE" call A3A_fnc_Modules_GetSettings
	};
	case "opfor": {
		_side = "OFSIDE" call A3A_fnc_Modules_GetSettings
	};
};
_side