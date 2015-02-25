/// COLLECT
/// GET LINKED MODULES
/// SORT LINKED MODULES IN GROUPS

/// CYCLE GROUPS
/// GET MODULE ORDER AND COMPLETION VARIABLE
/// IF GROUP MODULES COMPLETED - SHOW SUMMARY AND END MISSION

//// VARIABLES

/// MODULE VAR: a3a_var_module_isCompleted
// ARGUMENTS: isCompleted (BOOL)

/// MODULE VAR a3a_var_module_stats
// ARGUMENTS: [module name (LOCALIZE), win side (SIDE), start time, end time]

/// MODULE VAR a3a_var_module_message
// ARGUMENTS: [message LOCALIZE, args]

/// MODULE VAR a3a_var_module_canProcess
// ARGUMENTS: canProcess (BOOL)

a3a_var_srv_dummyModules =
	(allMissionObjects "A3A_FreezeVehiclesTimer") +
	(allMissionObjects "A3A_LockVehiclesTimer") +
	(allMissionObjects "A3A_ExternalFile");

a3a_var_srv_allModules =
	(allMissionObjects "A3A_EndMissionCapture") +
	(allMissionObjects "A3A_EndMissionCountUnits") +
	(allMissionObjects "A3A_EndMissionDeadInZone") +
	(allMissionObjects "A3A_EndMissionVipInZone") +
	(allMissionObjects "A3A_EndMissionTimer") +
	(allMissionObjects "A3A_EndMissionDeadUnits") +
	(allMissionObjects "A3A_EndMissionExternalFile") +
	(allMissionObjects "A3A_CombatLosses") +
	(allMissionObjects "A3A_EndMissionEscapeFromZone") +
	a3a_var_srv_dummyModules;

[] call A3A_fnc_Modules_GetModulesOrder;

if (!isServer) exitWith {};

waitUntil { sleep 0.281; missionNameSpace getVariable ["a3a_var_started", false] };

sleep 5;

_cycle = true;
while { _cycle } do {
	{
		_isDummy = true;
		_finish = true;
		/// PROCESS MODULES LEVELS ARRAY
		for "_i" from 0 to ((count _x) - 1) do {
			_processNextLevel = true;
			_mods_level = _x select _i;
			/// PROCESS LEVEL MODULE ARRAY
			for "_i2" from 0 to ((count _mods_level) - 1) do {
				_module = _mods_level select _i2;
				_canProcess = _module getVariable ["a3a_var_module_canProcess", false];
				if (!_canProcess) then { _module setVariable ["a3a_var_module_canProcess", true] };
				if !(_module in a3a_var_srv_dummyModules) then {
					_isDummy = false;
					_isCompleted = _module getVariable ["a3a_var_module_isCompleted", false];
					if (!_isCompleted) then {
						_processNextLevel = false;
						_finish = false;
					};
				};
				sleep 0.01;
			};
			if !(_processNextLevel) exitWith {};
			sleep 0.01;
		};
		if (_finish && !_isDummy) exitWith {
			_cycle = false;
			_x spawn A3A_fnc_Modules_EndMission;
		};
		sleep 0.01;
	} forEach a3a_var_modules_order;
	sleep 3.171
};