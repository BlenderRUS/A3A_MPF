_oldUnit = [_this, 0, objNull, [objNull]] call bis_fnc_param;
_newUnit = [_this, 1, objNull, [objNull]] call bis_fnc_param;
_respawn = [_this, 2, -1, [0]] call bis_fnc_param;
_respawnDelay = [_this, 3, -1, [0]] call bis_fnc_param;

if (!isNull _oldUnit) then {
	_oldUnit setPos [0,0,0]
};

BIS_fnc_feedback_allowPP = false;
{ _x ppEffectEnable false } forEach ["RadialBlur", "ChromAberration", "WetDistortion", "ColorCorrections", "DynamicBlur", "FilmGrain", "ColorInversion"];

//Compile functions
/*
CSSA3_fnc_classExists = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_classExists.sqf");
CSSA3_fnc_draw3DHUD = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_draw3DHUD.sqf");
CSSA3_fnc_mainSpectateFunctions = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_mainSpectateFunctions.sqf");
CSSA3_fnc_createSpectateDialog = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_createSpectateDialog.sqf");
CSSA3_fnc_mainUpdateLoop = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_mainUpdateLoop.sqf");
CSSA3_fnc_forceReopen = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_forceReopen.sqf");
CSSA3_fnc_unitListIndexChange = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_unitListIndexChanged.sqf");
CSSA3_fnc_updateUnitList = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_updateUnitList.sqf");
CSSA3_fnc_settingsHandler = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_settingsHandler.sqf");
CSSA3_fnc_camMove = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_camMove.sqf");
CSSA3_fnc_camRotate = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_camRotate.sqf");
CSSA3_fnc_LMBhandler = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_LMBhandler.sqf");
CSSA3_fnc_changeView = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_changeView.sqf");
CSSA3_fnc_ctrlActive = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_ctrlActive.sqf");
CSSA3_fnc_closeInteractRose = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_closeInteractRose.sqf");
CSSA3_fnc_addremoveFavourite = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_addremoveFavourite.sqf");
CSSA3_fnc_strToUnit = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_strToUnit.sqf");
CSSA3_fnc_findInNested = compile preprocessFileLineNumbers ("\CSSA3\functions\fn_findInNested.sqf");
*/

//Check if API vars are Nil.
_defaultSides = [playerSide];
if (!isNil "A3RU_SPEC_var_allSides") then {
	_defaultSides = [blufor, opfor, civilian, resistance];
};
if (isNil {CSSA3_onlySpectatePlayers}) then { CSSA3_onlySpectatePlayers = false };
if (isNil {CSSA3_lockThirdPerson}) then {CSSA3_lockThirdPerson = false};
if (isNil {CSSA3_allowedModes} || {count CSSA3_allowedModes < 1}) then {CSSA3_allowedModes = ["freeCam","firstPerson","thirdPerson"]};
if (isNil {CSSA3_bluforSpectateable} || {count CSSA3_bluforSpectateable < 1}) then {CSSA3_bluforSpectateable = _defaultSides};
if (isNil {CSSA3_opforSpectateable} || {count CSSA3_opforSpectateable < 1}) then {CSSA3_opforSpectateable = _defaultSides};
if (isNil {CSSA3_civilianSpectateable} || {count CSSA3_civilianSpectateable < 1}) then {CSSA3_civilianSpectateable = _defaultSides};
if (isNil {CSSA3_independentSpectateable} || {count CSSA3_independentSpectateable < 1}) then {CSSA3_independentSpectateable = _defaultSides};

//Calculate player's spectateable units.
_setSide = [] spawn {
	CSSA3_playerSide = playerSide;
	if (CSSA3_playerSide == blufor) exitWith { CSSA3_sideArray = CSSA3_bluforSpectateable };
	if (CSSA3_playerSide == opfor) exitWith { CSSA3_sideArray = CSSA3_opforSpectateable };
	if (CSSA3_playerSide == civilian) exitWith { CSSA3_sideArray = CSSA3_civilianSpectateable };
	if (CSSA3_playerSide == resistance) exitWith { CSSA3_sideArray = CSSA3_independentSpectateable };
};

if (!alive player) exitWith { ['killed', _this] spawn CSSA3_fnc_createSpectateDialog };