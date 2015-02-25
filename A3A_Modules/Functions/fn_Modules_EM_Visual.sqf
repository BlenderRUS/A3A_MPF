disableSerialization;

[] spawn {
	sleep 40;
	"A3A_End_1" call BIS_fnc_endMission;
};

AGM_Hearing_disableVolumeUpdate = true;
5 fadeSound 0;

a3a_var_cli_em_cam = "camera" camCreate ((vehicle player) modelToWorld [0,0,0]);
a3a_var_cli_em_cam camSetTarget (vehicle player);
a3a_var_cli_em_cam cameraEffect ["internal", "back"];
a3a_var_cli_em_cam camCommit 0;

playMusic "A3A_EndMission";
titleText ["", "BLACK IN", 6];
a3a_var_cli_em_ppEffect = ppEffectCreate ["RadialBlur", 1501];
a3a_var_cli_em_ppEffect ppEffectEnable true;

{
	if (count _x == 5) then {
		_eff = _x select 3;
		_adjust = _x select 4;
		if (isNil "_adjust") then {
			ppEffectDestroy _eff;
		} else {
			_eff ppEffectAdjust _adjust;
			_eff ppEffectCommit (_x select 1);
		};
	};
	a3a_var_cli_em_cam camSetPos ((vehicle player) modelToWorld (_x select 0));
	a3a_var_cli_em_cam camCommit (_x select 2);
	sleep (_x select 1);
} forEach [
	[[0,5,0.5], 6.85, 6.85, a3a_var_cli_em_ppEffect, [0.5, 0.5, 0.2, 0.2]],
	[[35,35,1], 1.7, 0.3, a3a_var_cli_em_ppEffect, [1.0, 1.0, 1, 1]],
	[[-35,35,0.7], 0.95, 0.3, a3a_var_cli_em_ppEffect, nil],
	[[35,-35,0.7], 0.8, 0.3],
	[[-30,-35,3], 1.6, 0.3],
	[[30,-36,6], 0.88, 0.3],
	[[-37,37,10], 0.88, 0.3]
];

createDialog "A3A_EndMission";
_display = uiNamespace getVariable ["A3A_EndMission", displayNull];

if (!isNull _display) then {
	#define IDC_A3A_ENDMISSION_TEXT		10473
	#define IDC_A3A_ENDMISSION_BACKGROUND	10573
	#define IDC_A3A_ENDMISSION_UAVPIC	10574
	
	a3a_var_cli_em_cam cameraEffect ["internal", "back", "rtt"];
	"rtt" setPiPEffect [2];
	_pic = _display displayCtrl IDC_A3A_ENDMISSION_UAVPIC;
	_pic ctrlSetText "#(argb,512,512,1)r2t(rtt,1.0)";
	_ctrl = _display displayCtrl IDC_A3A_ENDMISSION_TEXT;
	_pos = (vehicle player) modelToWorld [0,-2,100];
	a3a_var_cli_em_cam camSetPos _pos;
	a3a_var_cli_em_cam camCommit 20;
	
	_miss_name = (_this select 0) select 0;
	_miss_time = ((_this select 0) select 1) call a3a_fnc_convertTime;
			
	_endArray = [
		["", _miss_name, "size='1.3' align='left' color='#ffff00'", false],
		["image='\A3A_Modules\Resources\icon_clock.paa' width=12 height=12", " " + _miss_time, "align='right' size='1.1'", true]
	];
	
	_mods_array = _this select 1;
	
	for "_i" from 0 to ((count _mods_array) - 1) do {
		_module = _mods_array select _i;
		
		_mod_stats = _module select 0;
		_mod_message = _module select 1;
		
		_mod_name = _mod_stats select 0;
		if (typeName _mod_name == "ARRAY") then {
			_mod_name = _mod_name select 0;
		} else {
			_mod_name = localize _mod_name;
		};
		_mod_winSide = _mod_stats select 1;
		_mod_start = (_mod_stats select 2) call a3a_fnc_convertTime;
		_mod_end = (_mod_stats select 3) call a3a_fnc_convertTime;
		
		_endArray pushBack ["", "", "", true];
		_endArray pushBack ["", _mod_name, "color='#00ff00'", false];
		_endArray pushBack ["", " " + format[localize "STR_A3A_Modules_EM_WinSide", _mod_winSide], "", false];
		_endArray pushBack ["", " " + format[localize "STR_A3A_Modules_EM_StartEnd", _mod_start, _mod_end], "color='#00b300'", true];
		if (count _mod_message > 0) then {
			_var1 = "";
			_var2 = "";
			_var3 = "";
			_var4 = "";
			_var5 = "";
			
			for "_i" from 1 to ((count _mod_message) - 1) do {
				_arg = _mod_message select _i;
				call compile format["_var%1 = '%2'", _i, _arg];
			};
			
			_endArray pushBack ["", format[localize (_mod_message select 0), _var1, _var2, _var3, _var4, _var5], "", true];
		};
	};
	
	[_ctrl, _endArray] call A3A_fnc_Modules_EM_AnimateCursor;
};