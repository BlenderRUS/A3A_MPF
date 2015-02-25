/// CHECK IF A3A MISSION IS RUNNING
if (isClass (missionConfigFile >> "A3A_MissionParams")) then {
	[] spawn A3A_fnc_Modules_EndGameControl;

	if (isServer) then {
		[] spawn A3A_fnc_Modules_ObjectsRandomizer;
		if (!isDedicated) then {
			// CHECK UNITS FOR EACH SIDE IN mission_parameters.hpp
			_errors = ["A3A INIT",[["COUNT_SIDES", []]]] spawn A3A_fnc_Modules_CheckConditions;
		};
	};
};