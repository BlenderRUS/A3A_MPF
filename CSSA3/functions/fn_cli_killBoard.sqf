//--- a3a_killboard
#define IDC_A3A_KILLBOARD_LABEL		9094
#define IDC_A3A_KILLBOARD_ST_TEXT		9194
#define IDC_A3A_KILLBOARD_BACKGROUND	10294
#define IDC_A3A_KILLBOARD_CG_KILLBOARD	10394

private ["_display", "_ctrl", "_finalString", "_allys", "_enemies"];

disableSerialization;
_display = _this select 0;

if (!isNull _display) then {
	_ctrl = _display displayCtrl IDC_A3A_KILLBOARD_ST_TEXT;

	_finalString = "";
	
	_allys = missionNameSpace getVariable ["a3a_var_cli_killedAllies", []];
	_enemies = missionNameSpace getVariable ["a3a_var_cli_killedEnemies", []];
	
	if (((count _allys) == 0) && ((count _enemies) == 0)) then {
		_finalString = "No units has been killed!<br/>";
	} else {
		_finalString = "<t color='#0000ff'>Teamkills:</t><br/>";
		{
			_finalString = _finalString + format["%1<br/>", _x];
		} forEach _allys;
		_finalString = _finalString + "<br/><t color='#ff0000'>Enemies:</t><br/>";
		{
			_finalString = _finalString + format["%1<br/>", _x];
		} forEach _enemies;
	};
	if (!isNil "a3a_var_cli_myKiller") then {
		_finalString = _finalString + format["<br/><t color='#ffff00'>My Killer:</t><br/>%1", a3a_var_cli_myKiller];
	};
	_ctrl ctrlSetStructuredText parseText _finalString
};