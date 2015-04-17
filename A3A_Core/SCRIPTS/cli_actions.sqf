// Добавление в меню действий администратора: завершение подготовки
a3a_fnc_cli_action_endPrepare = {
	a3a_var_srv_timerSkip = true;
	publicVariableServer "a3a_var_srv_timerSkip";
	[["STR_A3RU_adminStarted", name player], 0] spawn a3a_fnc_message;
	"(ADMIN) End Prepare Time" spawn a3a_fnc_ui_Remove;
	a3a_fnc_cli_action_endPrepare = nil;
};
[
	'(ADMIN) End Prepare Time',
	'[]',
	'a3a_fnc_cli_action_endPrepare',
	'(serverCommandAvailable "#kick" || isServer) && !a3a_var_started'
] call a3a_fnc_ui_add;

// Добавление в меню действий администратора: завершение миссии
[
	'(ADMIN) Finish Mission',
	str(format['Mission finished by admin: %1', name player]),
	'a3a_fnc_endMission',
	'(serverCommandAvailable "#kick" || isServer) && a3a_var_started'
] call a3a_fnc_ui_add;

// Добавление в меню действий: Толкнуть лодку (Push boat)
[
	localize 'STR_A3RU_pushBoat',
	'[]',
	'a3a_fnc_pushBoat',
	'(cursorTarget isKindOf "ship") && player distance cursorTarget < 7'
] call a3a_fnc_ui_add;

_fireteamHUD = "FIRETEAMHUD" call A3A_fnc_Modules_GetSettings;
if (_fireteamHUD == 1) then {
	if (isClass (configFile >> "A3RU_PostInit_EventHandlers" >> "FireteamHUD")) then {
		a3ru_FTHUD_disabled = true;

		[
			localize 'STR_A3RU_FTHUDEnable',
			'0',
			'a3a_fnc_FTHUDShow',
			'a3ru_FTHUD_disabled && ("ItemTCubeMT" in (assignedItems player))'
		] call a3a_fnc_ui_add;
		
		[
			localize 'STR_A3RU_FTHUDDisable',
			'1',
			'a3a_fnc_FTHUDShow',
			'!a3ru_FTHUD_disabled'
		] call a3a_fnc_ui_add;
	};
};