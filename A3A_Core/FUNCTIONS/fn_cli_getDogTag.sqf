private ["_playerInfo", "_playerName", "_playerTag", "_layer", "_display", "_dogTagBackground", "_dogTagText"];
if (stance player == "STAND") then {
	hint parseText ("<img image='\A3A_Core\RESOURCES\a3a_dogTag_icon.paa'/> " + localize "STR_A3RU_tagNoStand");
} else {
	_playerInfo = _this getVariable ["PlayerName", ["NoName", 0]];
	_playerName = _playerInfo select 0;
	_playerTag = _playerInfo select 1;
	if (_playerTag == 1) then {
		_this setVariable ["PlayerName", [_playerName, 0], true];

		disableSerialization;
		_layer = "A3RU_dogTag" call BIS_fnc_rscLayer;
		_layer cutRsc ["A3RU_DOGTAG_UI","PLAIN"];
		_display = uiNamespace getVariable "A3RU_DOGTAG_UI";
		
		_dogTagBackground = _display displayCtrl 1200;
		_dogTagText = _display displayCtrl 1000;
		
		_dogTagBackground ctrlShow true;
		_dogTagText ctrlShow true;
		
		_dogTagText ctrlSetText _playerName;
	} else {
		hint parseText ("<img image='\A3A_Core\RESOURCES\a3a_dogTag_icon.paa'/> " + localize "STR_A3RU_noTagsFound");
	};
};