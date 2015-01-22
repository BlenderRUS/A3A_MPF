private ["_BFSide", "_OFSide", "_ver"];

_BFSide = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "blueforSide"));
_OFSide = call compile (getText (MissionConfigFile >> "A3A_MissionParams" >> "opforSide"));
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

_ver = getNumber (ConfigFile >> "CfgPatches" >> "A3A_Core" >> "version");
player createDiaryRecord ["diary", [localize "STR_A3RU_Intel",
	format ["%1<br/><br/>Версия платформы Atrium: %2<br/>Автор платформы: [SUB7]Blender",
		loadFile "A3A_BRIEFING\briefing_MISSION_DESCRIPTION.html",
		_ver
	]
]];