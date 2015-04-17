/*_oldUnit = [_this, 0, objNull, [objNull]] call bis_fnc_param;
_newUnit = [_this, 1, objNull, [objNull]] call bis_fnc_param;
_respawn = [_this, 2, -1, [0]] call bis_fnc_param;
_respawnDelay = [_this, 3, -1, [0]] call bis_fnc_param;
if (!isNull _oldUnit) then {
	_oldUnit setPos [0,0,0]
};*/
CSSA3_Seagull = _this select 0;

if (isNil {CSSA3_Seagull} || {isNull CSSA3_Seagull}) then
{
	CSSA3_Seagull = _this select 1;
};

if (!( isNil {CSSA3_Seagull} || {isNull CSSA3_Seagull} )) then {
	CSSA3_Seagull setPos [-10000,-10000,5000];
	CSSA3_Seagull enableSimulation false;
	
	CSSA3_Seagull spawn
	{
		while {!(
				isNil {_this} ||
				{isNull _this} || 
				{((getPosWorld _this) select 0) < -1000}
			)} do
		{
			_this setPos [-10000,-10000,5000];
			sleep 0.1;
		};
	};
};

BIS_fnc_feedback_allowPP = false;
{ _x ppEffectEnable false } forEach ["RadialBlur", "ChromAberration", "WetDistortion", "ColorCorrections", "DynamicBlur", "FilmGrain", "ColorInversion"];

//Check if API vars are Nil.
_defaultSides = [blufor, opfor, civilian, resistance];
if (isClass (missionConfigFile >> "A3A_MissionParams") && !(isNil "A3RU_SPEC_var_allSides")) then {
	_defaultSides = [playerSide];
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

//if (!alive player) exitWith {
	['killed', _this] spawn CSSA3_fnc_createSpectateDialog
//};