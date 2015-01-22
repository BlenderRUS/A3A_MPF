// FUNCTIONS
a3a_fnc_brief_collectModules = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_brief_collectModules.sqf";
a3a_fnc_brief_vehMark = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_brief_vehMark.sqf";
a3a_fnc_brief_vehMarkDelete = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_brief_vehMarkDelete.sqf";
a3a_fnc_brief_addGroups = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_brief_addGroups.sqf";
a3a_fnc_brief_markGroups = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_brief_markGroups.sqf";
a3a_fnc_brief_markGroupsDelete = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_brief_markGroupsDelete.sqf";
a3a_fnc_brief_writeBriefing = compile preprocessFileLineNumbers "\A3A_Core\FUNCTIONS\fn_brief_writeBriefing.sqf";

[] call a3a_fnc_brief_collectModules;

if !(a3a_var_started) then {
	private ["_firedEHIndex", "_startPos", "_markerSize", "_marker"];

	_firedEHIndex = player addEventHandler ["fired", {deleteVehicle (_this select 6)}];
	_startPos = player getVariable ["StartPos", nil];
	if (isNil "_startPos") then {
		_startPos = getPos player;
		player setVariable ["StartPos", _startPos, true];
	};
	_markerSize = getNumber (MissionConfigFile >> "A3A_MissionParams" >> "prepareZoneSize");
	_marker = "prepareZone";
	createMarkerLocal[_marker, _startPos];
	_marker setMarkerSizeLocal [_markerSize, _markerSize];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerTypeLocal "EMPTY";
	_marker setMarkerColorLocal "ColorGreen";
	
	[] call a3a_fnc_brief_markGroups;
	[] call a3a_fnc_brief_writeBriefing;

	waitUntil { sleep 0.1; a3a_var_started };
	
	deleteMarkerLocal _marker;
	
	[] call a3a_fnc_brief_vehMarkDelete;
	[] call a3a_fnc_brief_markGroupsDelete;
	player removeEventHandler ["fired", _firedEHIndex];
} else {
	[] call a3a_fnc_brief_writeBriefing;
};

// * Functions cleanup
a3a_fnc_brief_collectModules = nil;
a3a_fnc_brief_vehMark = nil;
a3a_fnc_brief_vehMarkDelete = nil;
a3a_fnc_brief_addGroups = nil;
a3a_fnc_brief_markGroups = nil;
a3a_fnc_brief_markGroupsDelete = nil;
a3a_fnc_brief_writeBriefing = nil;