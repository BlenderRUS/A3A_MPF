#define A3A_IMG_READY "\A3A_Core\RESOURCES\a3a_cb_true.paa"
#define A3A_IMG_NOTREADY "\A3A_Core\RESOURCES\a3a_cb_false.paa"

private [
	"_display",
	"_layer",
	"_counterText",
	"_counterCbSide_1",
	"_counterCbSide_2",
	"_counterTextSide_1",
	"_counterTextSide_2",
	"_counterLeadersSide_1",
	"_counterLeadersSide_2",
	"_text_side_1",
	"_text_side_2",
	"_minutes",
	"_seconds",
	"_text_leaders_side_1",
	"_text_leaders_side_2",
	"_side_1_count",
	"_side_2_count",
	"_side_1_ready",
	"_side_2_ready",
	"_side_1_leaders",
	"_side_2_leaders",
	"_unit",
	"_color",
	"_unitReady"
];

disableSerialization;
_display = uiNamespace getVariable ["A3A_Counter", displayNull];
if (isNull _display && !a3a_var_started) then {
	_layer = "A3A_Counter" call BIS_fnc_rscLayer;
	_layer cutRsc ["A3A_Counter", "PLAIN", 2];

	_display = uiNamespace getVariable ["A3A_Counter", displayNull];

	_counterText = _display displayCtrl 1000;
	_counterCbSide_1 = _display displayCtrl 1201;
	_counterCbSide_2 = _display displayCtrl 1202;
	_counterTextSide_1 = _display displayCtrl 1102;
	_counterTextSide_2 = _display displayCtrl 1103;
	_counterLeadersSide_1 = _display displayCtrl 1100;
	_counterLeadersSide_2 = _display displayCtrl 1101;
	
	_text_side_1 = "bluefor" call a3a_fnc_getSide;
	_text_side_2 = "opfor" call a3a_fnc_getSide;

	_counterTextSide_1 ctrlSetStructuredText parseText format["<t size='1.1' color='#0000ff'>%1</t>", _text_side_1];
	_counterTextSide_2 ctrlSetStructuredText parseText format["<t size='1.1' color='#ff0000'>%1</t>", _text_side_2];
	
	waitUntil { sleep 0.01; !isNil "a3a_var_timeCorrection" || a3a_var_started };
	
	[] spawn {
		waitUntil {sleep 0.5; !isNil "a3a_var_leadersArray"};
		if (player in ((a3a_var_leadersArray select 0) + (a3a_var_leadersArray select 1))) then {
			a3a_fnc_cli_action_voteToStart = {
				_ready = player getVariable ["A3A_Ready", false];
				if (!isMultiplayer) then {
					[player, !_ready] spawn a3a_fnc_srv_counter_setVote
				} else {
					a3a_var_srv_counter_setVote = [player, !_ready];
					publicVariableServer "a3a_var_srv_counter_setVote"
				}
			};
			// ADD VOTE ACTION
			[
				'Vote to Start Mission',
				'[]',
				'a3a_fnc_cli_action_voteToStart',
				'!a3a_var_started'
			] call a3a_fnc_ui_add;
			waitUntil { sleep 5.217; a3a_var_started };
			"Vote to Start Mission" call a3a_fnc_ui_Remove;
			a3a_fnc_cli_action_voteToStart = nil;
		};
	};

	while { !a3a_var_started } do {
		
		_counterText ctrlSetText (a3a_var_timeCorrection call a3a_fnc_convertTime);
		
		if (!isNil "a3a_var_leadersArray") then {
			_text_leaders_side_1 = "";
			_text_leaders_side_2 = "";

			_side_1_count = 0;
			_side_2_count = 0;

			_side_1_ready = 0;
			_side_2_ready = 0;
			
			_side_1_leaders = a3a_var_leadersArray select 0;
			_side_2_leaders = a3a_var_leadersArray select 1;
			
			// SIDE 1 COUNT
			for "_i" from 0 to ((count _side_1_leaders) - 1) do {
				_unit = _side_1_leaders select _i;
				if (!isNull _unit) then {
					if (alive _unit && isPlayer _unit) then {
						_color = "#ffffff";
						_unitReady = _unit getVariable ["A3A_Ready", false];
						_side_1_count = _side_1_count + 1;
						if (_unitReady) then {
							_color = "#00ff00";
							_side_1_ready = _side_1_ready + 1;
						};
						_text_leaders_side_1 = _text_leaders_side_1 + format["<t size='0.7' color='%1'>%2</t><br/>", _color, name _unit];
					};
				};
			};
			
			// SIDE 2 COUNT
			for "_i" from 0 to ((count _side_2_leaders) - 1) do {
				_unit = _side_2_leaders select _i;
				if (!isNull _unit) then {
					if (alive _unit && isPlayer _unit) then {
						_color = "#ffffff";
						_unitReady = _unit getVariable ["A3A_Ready", false];
						_side_2_count = _side_2_count + 1;
						if (_unitReady) then {
							_color = "#00ff00";
							_side_2_ready = _side_2_ready + 1;
						};
						_text_leaders_side_2 = _text_leaders_side_2 + format["<t size='0.7' color='%1'>%2</t><br/>", _color, name _unit];
					};
				};
			};

			// CHECKBOX
			if ((_side_1_count > 0) && (_side_1_count == _side_1_ready)) then {
				_counterCbSide_1 ctrlSetText A3A_IMG_READY;
			} else {
				_counterCbSide_1 ctrlSetText A3A_IMG_NOTREADY;
			};
			if ((_side_2_count > 0) && (_side_2_count == _side_2_ready)) then {
				_counterCbSide_2 ctrlSetText A3A_IMG_READY;
			} else {
				_counterCbSide_2 ctrlSetText A3A_IMG_NOTREADY;
			};

			// LEADERS
			_counterLeadersSide_1 ctrlSetStructuredText parseText _text_leaders_side_1;
			_counterLeadersSide_2 ctrlSetStructuredText parseText _text_leaders_side_2;
		};
		
		a3a_var_timeCorrection = a3a_var_timeCorrection - 1;
		sleep 1;
	};
	_counterCbSide_1 ctrlSetText A3A_IMG_READY;
	_counterCbSide_2 ctrlSetText A3A_IMG_READY;
	_counterText ctrlSetText "STARTED";
	playSound "a3a_started";
	sleep 4;
	_layer cutText ["", "PLAIN"];
};