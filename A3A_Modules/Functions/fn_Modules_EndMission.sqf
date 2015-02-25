{ _x enableSimulationGlobal false } forEach (vehicles + allUnits);

_var_modulesInfoArray = [];
/// PROCESS MODULES LEVELS ARRAY
for "_i" from 0 to ((count _this) - 1) do {
	_mods_level = _this select _i;
	/// PROCESS LEVEL MODULE ARRAY
	for "_i2" from 0 to ((count _mods_level) - 1) do {
		_module = _mods_level select _i2;
		_mod_stats = _module getVariable ["a3a_var_module_stats", nil];
		if (!isNil "_mod_stats") then {
			_mod_message = _module getVariable ["a3a_var_module_message", []];
			_var_modulesInfoArray SET [count _var_modulesInfoArray, [_mod_stats, _mod_message]];
		};
	};
	sleep 0.01;
};

a3a_var_endMissionOnModule = [[getText (missionConfigFile >> "onLoadName"), call a3a_fnc_srv_getMissionTime], _var_modulesInfoArray];

publicVariable "a3a_var_endMissionOnModule";
if (!isDedicated) then { a3a_var_endMissionOnModule spawn A3A_fnc_Modules_EM_Visual };
sleep 40;
"A3A_End_1" call BIS_fnc_endMission;