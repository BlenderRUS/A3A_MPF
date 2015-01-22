_unit = _this select 0;

_unit allowFleeing 0;
_unit disableAI "AUTOTARGET";
_unit disableAI "ANIM";
_unit disableAI "FSM";
_unit disableAI "MOVE";
_unit disableAI "PATHPLAN";
_unit doWatch objNull;
_unit setVariable ["BIS_noCoreConversations", true];

if (count _this > 1) then {
	removeAllWeapons _unit;
	removeBackpack _unit;

	_unitSide = _this select 1;
	_unitEquip = _this select 2;

	_unit setVariable ["A3A_EQUIPMENT", [_unitSide, _unitEquip], true];

	if (isServer && !isDedicated) then {
		_selectedEquip = _unitEquip call compile preprocessFileLineNumbers format["A3A_EQUIPMENT\equip_%1.sqf", _unitSide];
		if (count _selectedEquip == 13) then {
			hint "WARNING! WRONG CLASS IN UNIT INIT!\nCHECK LOG FILE!";
			diag_log format["WARNING!!! Unit %1 > %2 > %3 wrong class init name!", _unitSide, _unit, _unitEquip];
		};
	};
};