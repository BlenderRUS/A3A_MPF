// Project: ArmA 3 Atrium Framework
// Author: Blender
// E-mail: blender@arma3.ru
// Specially for ARMA3.RU Community: http://www.arma3.ru

// Variable for platform modules
a3a_var_cli_preInit = false;
a3a_var_cli_postInit = false;

// ****************** FUNCTIONS INIT ******************
a3a_fnc_getMessage = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_getMessage.sqf";
a3a_fnc_getSide = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_getSide.sqf";
a3a_fnc_message = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_message.sqf";
a3a_fnc_endMission = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_endMission.sqf";
a3a_fnc_cli_counter = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_cli_counter.sqf"; // Timer visualisation
a3a_fnc_onKeyDown = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_onKeyDown.sqf";
a3a_fnc_ui_add = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_ui_add.sqf";
a3a_fnc_ui_remove = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_ui_remove.sqf";
a3a_fnc_onKeyUp = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_onKeyUp.sqf";
a3a_fnc_pb_visual = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_pb_visual.sqf";
a3a_fnc_pushBoat = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_pushBoat.sqf";
a3a_fnc_FTHUDShow = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_FTHUDShow.sqf";
a3a_fnc_vehicleFreeze = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_vehicleFreeze.sqf";
a3a_fnc_ratingControl = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_ratingControl.sqf";
a3a_fnc_cli_spawnZoneRestriction = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_cli_spawnZoneRestriction.sqf";
a3a_fnc_cli_getDogTag = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_cli_getDogTag.sqf";
// ----------------- FUNCTIONS INIT ------------------

waitUntil { player == player };

[] call compile preprocessFileLineNumbers "\A3A_Core\SCRIPTS\setMissionParams.sqf";

// PreBriefing external addons
if (a3a_param_externalAddons == 1) then {
	_configClass = configFile >> "A3A_PreBriefing_EventHandlers";
	if (isClass _configClass) then	{
		_a3ru_count = count _configClass;
		if (_a3ru_count > 0) then {
			for "_i" from 0 to (_a3ru_count - 1) do {
				_configEntry = _configClass select _i;
				_clientInit = _configEntry / "clientInit";
				if (isText _clientInit) then {
					call compile(getText _clientInit);
				};
			};
		};
	};
};

"a3a_var_broadCast" addPublicVariableEventHandler { (_this select 1) call a3a_fnc_getMessage };
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

enableRadio false;
enableSentences false;
enableEngineArtillery false;

waitUntil { !isNil "a3a_var_started" || !(alive player)}; // Wait for init

[] execVM "\A3A_Core\SCRIPTS\a3a_briefing.sqf";

a3a_var_cli_postInit = true;

waitUntil { time > 0 && (!isNull (findDisplay 46)) };

// Set view distance
setViewDistance (getNumber (MissionConfigFile >> "A3A_MissionParams" >> "viewDistance"));

[] execVM "\A3A_Core\SCRIPTS\tfar_settings.sqf"; // TFAR Settings

if !(alive player) exitWith {};

[] spawn a3a_fnc_cli_spawnZoneRestriction;

// Slot reservation check
if (!isNull player && (a3a_param_slotReservation == 0)) then {
	[] execVM "\A3A_Core\SCRIPTS\cli_slotReservation.sqf";
};

// Killer eventhandler
_EHkilledIdx = player addEventHandler ["killed", { a3ru_var_myKiller = name (_this select 1); diag_log format["KILLED BY: %1", a3ru_var_myKiller] }];

a3a_var_key_interactionMenu = [221, false, false, false];
["a3a_var_key_interactionMenu", localize "STR_A3RU_UAC_Atrium", localize "STR_A3RU_UAC_Interaction", "Interaction"] call d_uac_fnc_registerKeyBindingVariable;

a3a_var_key_specator_endMission = [221, true, true, false];
["a3a_var_key_specator_endMission", localize "STR_A3RU_UAC_Atrium", localize "STR_A3RU_UAC_Spectator_EndMission", "EndMission"] call d_uac_fnc_registerKeyBindingVariable;

a3a_UI_array = [];
a3a_UI_DEH = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call a3a_fnc_onKeyDown"];
(findDisplay 46) displayAddEventHandler ["KeyUp", "_this call a3a_fnc_onKeyUp"];

[] spawn a3a_fnc_ratingControl;
[] spawn a3a_fnc_vehicleFreeze;
[] execVM "\A3A_Core\SCRIPTS\cli_dogTags.sqf";

/// Name: Save player name
/// Type: Logic
/// Description: Stores player's name to a global public variable
/// Parameters: None
player setVariable ["PlayerName", [name player, 1], true];

/// Name: Save player side
/// Type: Logic
/// Description: Stores player's object side to a global variable
/// Parameters: None
_playerSide = player getVariable ["A3A_PlayerSide", nil];
if (isNil "_playerSide") then { player setVariable ["A3A_PlayerSide", playerSide, true] };

/// Name: Introduction
/// Type: Logic
/// Description: Shows introduction on prepare time when player joins & intro parameter is set in mission config
/// Parameters: (Integer) _sg
_sg = getNumber (MissionConfigFile >> "A3A_MissionParams" >> "UAVIntro");
if (_sg == 1 && !(a3a_var_started) && !(isServer)) then {
	[getPos player, "ARMA3.RU UAV Intel // " + localize "STR_A3RU_MissionName" + " - " + (getText (missionConfigFile >> "onLoadName")), 110, 150, 0, 0, [["\a3\ui_f\data\map\markers\nato\b_inf.paa", [0.1, 0.5, 1, 0.78], getPos player, 1, 1, 0, name player, 0]] ] call BIS_fnc_establishingShot;
};

/// Name: Prepare time countdown
/// Type: Logic
/// Description: Stores player's object side to a global variable
/// Parameters: None
[] spawn a3a_fnc_cli_counter;

"a3ru_zoneCap" addPublicVariableEventHandler { (_this select 1) spawn a3a_fnc_pb_visual };
"a3ru_event_zoneCap" addPublicVariableEventHandler { [] spawn a3ru_fnc_Module_ZoneCaptureVisual }; // Module zone cap event

/// Name: Init equipment
/// Type: Function
/// Description: Main equipment initialization
/// Parameters: None
[] spawn { call compile preprocessFileLineNumbers "\A3A_Core\SCRIPTS\init_equipment.sqf" };

/// Name: Engine artillery
/// Type: Logic
/// Description: Enable artillery engine for mortars after start
/// Parameters: None
[] spawn { waitUntil { sleep 3.137; a3a_var_started }; enableEngineArtillery true };

[] spawn { call compile preprocessFileLineNumbers "\A3A_Core\SCRIPTS\cli_actions.sqf" };

[] spawn { call compile preprocessFileLineNumbers "a3a_client_scripts.sqf" };

waitUntil { sleep 0.1; a3a_var_started };

// PostBriefing external addons
if (a3a_param_externalAddons == 1) then {
	_configClass = configFile >> "A3A_PostBriefing_EventHandlers";
	if (isClass _configClass) then	{
		_a3ru_count = count _configClass;
		if (_a3ru_count > 0) then {
			for "_i" from 0 to (_a3ru_count - 1) do {
				_configEntry = _configClass select _i;
				_clientInit = _configEntry / "clientInit";
				if (isText _clientInit) then {
					call compile(getText _clientInit);
				};
			};
		};
	};
};