private ["_BFSide", "_OFSide", "_ver"];

_BFSide = "BFSIDE" call A3A_fnc_Modules_GetSettings;
_OFSide = "OFSIDE" call A3A_fnc_Modules_GetSettings;
switch (side player) do {
	case _BFSide: {
		player createDiaryRecord ["diary", [localize "STR_A3RU_Enemy", loadFile "A3A_BRIEFING\briefing_BLUEFOR_ENEMY.html"]];
		player createDiaryRecord ["diary", [localize "STR_A3RU_Tasks", loadFile "A3A_BRIEFING\briefing_BLUEFOR_TASKS.html"]];
	};
	case _OFSide: {
		player createDiaryRecord ["diary", [localize "STR_A3RU_Enemy", loadFile "A3A_BRIEFING\briefing_OPFOR_ENEMY.html"]];
		player createDiaryRecord ["diary", [localize "STR_A3RU_Tasks", loadFile "A3A_BRIEFING\briefing_OPFOR_TASKS.html"]];
	};
};

_core_ver = getText (ConfigFile >> "CfgPatches" >> "A3A_Core" >> "versionStr");
_mods_ver = getText (ConfigFile >> "CfgPatches" >> "A3A_Modules" >> "versionStr");
_miss_ver = getNumber (MissionConfigFile >> "atrium_version");
player createDiaryRecord ["diary", [localize "STR_A3RU_Intel",
	format [localize "STR_A3A_BriefVersion",
		loadFile "A3A_BRIEFING\briefing_MISSION_DESCRIPTION.html",
		_core_ver,
		_mods_ver,
		_miss_ver
	]
]];