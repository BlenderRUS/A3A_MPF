disableSerialization;
private ["_trigger", "_layer", "_display", "_ctrl_progress", "_ctrl_text", "_text", "_progress_size", "_firstUpdate"];

_trigger = a3a_event_zoneCap select 0;
_triggerArea = a3a_event_zoneCap select 1;
_zoneName = a3a_event_zoneCap select 5;

_trigger setTriggerArea _triggerArea;
_trigger setTriggerActivation["ANY", "PRESENT", false];
_trigger setTriggerStatements["false", "", ""];
_trigger setTriggerTimeout [15, 15, 15, false];

if (player in ((list _trigger) call A3A_fnc_Modules_GetCrewUnits)) then {
	if (isNil "a3a_var_capVisualEnabled") then { a3a_var_capVisualEnabled = false };

	if (!a3a_var_capVisualEnabled) then {
		a3a_var_capVisualEnabled = true;
		
		_layer = "ATRIUM_CAP_PROGRESS_UI" call BIS_fnc_rscLayer;
		_layer cutRsc ["ATRIUM_CAP_PROGRESS_UI", "PLAIN"];

		_display = uiNamespace getVariable "ATRIUM_CAP_PROGRESS_UI";
		_ctrl_progress = _display displayCtrl 1201;
		_ctrl_text = _display displayCtrl 1000;

		_progress_size = ctrlPosition _ctrl_progress;

		_firstUpdate = true;
		
		while { player in ((list _trigger) call A3A_fnc_Modules_GetCrewUnits) } do {
			private ["_zoneOwner", "_zoneCapped", "_zoneStatus"];
				if (a3a_event_zoneCap select 0 == _trigger) then {
				_zoneOwner = a3a_event_zoneCap select 2; // Owner (0-neutral, 1-west, 2-east)
				_zoneCapped = floor (a3a_event_zoneCap select 3); // Cap percentage (0-100)
				if (_zoneCapped > 100) then { _zoneCapped = 100 };
				_zoneStatus = a3a_event_zoneCap select 4; // Zone Status (0-Zone empty, 1-west capturing, 2-east capturing, 3-equal forces)
				
				switch (_zoneOwner) do {
					case 0: { _ctrl_progress ctrlSetText "\A3A_Modules\Resources\neut_cap.paa" };
					case 1: { _ctrl_progress ctrlSetText "\A3A_Modules\Resources\blue_cap.paa" };
					case 2: { _ctrl_progress ctrlSetText "\A3A_Modules\Resources\red_cap.paa" };
				};
				_ctrl_progress ctrlSetPosition [_progress_size select 0, _progress_size select 1, _zoneCapped / 100 * (_progress_size select 2), _progress_size select 3];
				if (_firstUpdate) then {
					_firstUpdate = false;
					_ctrl_progress ctrlCommit 0;
				} else {
					_ctrl_progress ctrlCommit 1;
				};
				
				_text = _zoneName + ". ";
				if (_zoneStatus == 0) then { _text = _text + localize "STR_A3A_Modules_EndMissionCapture_Capping" } else { _text = _text + localize "STR_A3A_Modules_EndMissionCapture_Holding" };
				if (_zoneOwner == 0) then { _text = _text + " " + localize "STR_A3A_Modules_EndMissionCapture_Equal" };
				
				_ctrl_text ctrlSetText _text;
			};
			sleep 1.216;
		};
		
		_layer cutText ["", "PLAIN", 2];
		_ctrl_progress ctrlSetPosition _progress_size;
		_ctrl_progress ctrlCommit 1;
		
		a3a_var_capVisualEnabled = false;
	};
};