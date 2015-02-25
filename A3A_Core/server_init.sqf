// Variable for platform modules
a3a_var_srv_postInit = false;
a3a_var_missionFinished = false;
a3a_var_srv_startNow = false;
a3a_var_started = false;
a3a_var_srv_startTime = diag_tickTime;
publicVariable "a3a_var_started";

_script = [] execVM "\A3A_Core\SCRIPTS\setMissionParams.sqf";
waitUntil { scriptDone _script };

// PreBriefing external addons
if (a3a_param_externalAddons == 1) then {
	_configClass = configFile >> "A3A_PreBriefing_EventHandlers";
	if (isClass _configClass) then	{
		_a3ru_count = count _configClass;
		if (_a3ru_count > 0) then {
			for "_i" from 0 to (_a3ru_count - 1) do {
				_configEntry = _configClass select _i;
				_serverInit = _configEntry / "serverInit";
				if (isText _serverInit) then {
					call compile(getText _serverInit);
				};
			};
		};
	};
};

// Functions
/*
a3a_fnc_getMessage = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_getMessage.sqf";
a3a_fnc_getSide = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_getSide.sqf";
a3a_fnc_message = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_message.sqf";
a3a_fnc_endMission = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_endMission.sqf";
a3a_fnc_endMissionTimer = compile preProcessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_endMissionTimer.sqf";
a3a_fnc_endMissionCountUnits = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_endMissionCountUnits.sqf";
a3a_fnc_endMissionCapture = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_endMissionCapture.sqf";
a3a_fnc_endMissionDeadInZone = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_endMissionDeadInZone.sqf";
a3a_fnc_endMissionDeadInZones = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_endMissionDeadInZones.sqf";
a3a_fnc_showMessageCountUnits = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_showMessageCountUnits.sqf";
a3a_fnc_endMissionZonesCapture = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_endMissionZonesCapture.sqf";
//**COUNTDOWN
a3a_fnc_srv_counter_setVote = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_srv_counter_setVote.sqf";
a3a_fnc_srv_counter_countVote = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_srv_counter_countVote.sqf";
a3a_fnc_srv_counter = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_srv_counter.sqf";
////COUNTDOWN
a3a_fnc_srv_startCleanUp = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_srv_startCleanUp.sqf";
a3a_fnc_srv_getMissionTime = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_srv_getMissionTime.sqf";
a3a_fnc_convertTime = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_convertTime.sqf";
A3A_fnc_GetBFSide = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_GetBFSide.sqf";
A3A_fnc_GetOFSide = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_GetOFSide.sqf";
*/

"a3a_var_endMission" addPublicVariableEventHandler {
	_this = _this select 1;
	if (typeName _this == "STRING") then {
		["end5",true,true] spawn BIS_fnc_endMission
	} else {
		if (side player == _this) then {
			["end5",true,true] spawn BIS_fnc_endMission
		} else {
			["end5",false,true] spawn BIS_fnc_endMission
		};
	};
};

"a3a_var_srv_counter_setVote" addPublicVariableEventHandler { (_this select 1) spawn a3a_fnc_srv_counter_setVote };

if (a3a_param_slotReservation == 0) then {
	[] execVM "\A3A_Core\SCRIPTS\srv_slotReservation.sqf"
};

[] spawn { call compile preprocessFileLineNumbers "a3a_server_scripts.sqf" };

waitUntil { time > 0 };

// PostBriefing external addons
if (a3a_param_externalAddons == 1) then {
	_configClass = configFile >> "A3A_PostBriefing_EventHandlers";
	if (isClass _configClass) then	{
		_a3ru_count = count _configClass;
		if (_a3ru_count > 0) then {
			for "_i" from 0 to (_a3ru_count - 1) do {
				_configEntry = _configClass select _i;
				_serverInit = _configEntry / "serverInit";
				if (isText _serverInit) then {
					call compile(getText _serverInit);
				};
			};
		};
	};
};

a3a_var_srv_postInit = true;

/// START COUNTDOWN & WAIT UNTIL STARTED
[a3a_param_preTime] call a3a_fnc_srv_counter;
a3a_fnc_srv_counter = nil; // * Clean function

/// REMOVE BOTS
[] call a3a_fnc_srv_startCleanUp;
a3a_fnc_srv_startCleanUp = nil; // * Clean function

a3a_var_srv_startTime = diag_tickTime;
a3a_var_started = true;
publicVariable "a3a_var_started";