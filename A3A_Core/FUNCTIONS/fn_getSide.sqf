private "_side";
switch (toLower _this) do {
	default { _side = WEST };
	case "bluefor": {
		_side = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"))
	};
	case "opfor": {
		_side = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"))
	};
};
_side