// Weapon equipment
private ["_playerSide", "_unitSide", "_unitEquip"];

_weap_check = player getVariable ["WeaponTaken", false];
if (_weap_check) exitWith {};

_equipArray = player getVariable ["A3A_EQUIPMENT", nil];
if (isNil "_equipArray") exitWith {
	player setVariable ["WeaponTaken", true, true];
};
_unitSide = _equipArray select 0;
_unitEquip = _equipArray select 1;

_selectedEquip = _unitEquip call compile preprocessFileLineNumbers format["A3A_EQUIPMENT\equip_%1.sqf", _unitSide];

a3ru_w_primary = (_selectedEquip select 0) + ["empty"];
a3ru_w_primary_mag = (_selectedEquip select 1);
a3ru_w_mod1 = (_selectedEquip select 2) + ["empty"];
a3ru_w_mod2 = (_selectedEquip select 3) + ["empty"];
a3ru_w_mod3 = (_selectedEquip select 4) + ["empty"];
a3ru_w_secondary = (_selectedEquip select 5) + ["empty"];
a3ru_w_secondary_mag = (_selectedEquip select 6);
a3ru_w_secondary_mods = (_selectedEquip select 7);
a3ru_w_side = (_selectedEquip select 8) + ["empty"];
a3ru_w_side_mag = (_selectedEquip select 9);
a3ru_w_items = (_selectedEquip select 10);
a3ru_w_back = (_selectedEquip select 11) + ["empty"];

fnc_a3ru_weap_iter = {
	private ["_b_slot", "_b_pic", "_b_name", "_b_type"];
	_action = _this select 0;
	_this = _this select 1;
	switch (_this) do {
		case 0: {
			_b_slot = a3ru_w_primary;
			_b_pic = 1200;
			_b_name = 1400;
			_b_type = "CfgWeapons";
		};
		case 1: {
			_b_slot = a3ru_w_mod1;
			_b_pic = 1201;
			_b_name = -1;
			_b_type = "CfgWeapons";
		};
		case 2: {
			_b_slot = a3ru_w_mod2;
			_b_pic = 1202;
			_b_name = -1;
			_b_type = "CfgWeapons";
		};
		case 3: {
			_b_slot = a3ru_w_mod3;
			_b_pic = 1203;
			_b_name = -1;
			_b_type = "CfgWeapons";
		};
		case 4: {
			_b_slot = a3ru_w_secondary;
			_b_pic = 1204;
			_b_name = 1401;
			_b_type = "CfgWeapons";
		};
		case 5: {
			_b_slot = a3ru_w_side;
			_b_pic = 1205;
			_b_name = 1402;
			_b_type = "CfgWeapons";
		};
		case 6: {
			_b_slot = a3ru_w_back;
			_b_pic = 1206;
			_b_name = 1403;
			_b_type = "CfgVehicles";
		};
	};
	if (count _b_slot > 0) then {
		if (_action == 0) then {
			if ((a3ru_weapvar select _this) == 0) then {
				a3ru_weapvar SET [_this, (count _b_slot) - 1];
			} else {
				a3ru_weapvar SET [_this, (a3ru_weapvar select _this) - 1];
			};
		} else {
			if ((a3ru_weapvar select _this) >= (count _b_slot) - 1) then {
				a3ru_weapvar SET [_this, 0];
			} else {
				a3ru_weapvar SET [_this, (a3ru_weapvar select _this) + 1];
			};
		};
		if ((a3ru_weapvar select _this) == (count _b_slot) - 1) then {
			ctrlSetText [_b_pic, "A3A_Core\RESOURCES\a3a_empty.paa"];
			((findDisplay 1350) displayCtrl _b_pic) ctrlSetTooltip localize "STR_A3RU_weap_notsel";
			hintSilent "";
			if (_b_name != -1) then {
				ctrlSetText [_b_name, localize "STR_A3RU_weap_notsel"];
			};
		} else {
			_item_config = ConfigFile >> _b_type >> _b_slot select (a3ru_weapvar select _this);
			_item_name = getText (_item_config >> "displayName");
			_item_description = getText (_item_config >> "Library" >> "libtextdesc");
			ctrlSetText [_b_pic, getText (_item_config >> "picture")];
			((findDisplay 1350) displayCtrl _b_pic) ctrlSetTooltip _item_name;
			hintSilent parseText format['<t color="#48a200">[</t><t color="#ffff00">ITEM INFO</t><t color="#48a200">]</t><br/>%1<br/>----------------<br/>%2', _item_name, _item_description];
			if (_b_name != -1) then {
				if (_b_name == 1403) then {
					_b_disLoad = getNumber (_item_config >> "maximumload");
					ctrlSetText [_b_name, format["%1 \ %2", _item_name, _b_disLoad]];
				} else {
					ctrlSetText [_b_name, _item_name];
				};
			};
		};
	};
};

fnc_a3ru_weap_canAddMagazines = {
	private ["_unit", "_item", "_amount"];
	_unit = _this select 0;
	_item = (_this select 1) select 0;
	_amount = (_this select 1) select 1;
	
	for "_i" from 1 to (_amount) do {
		if (_unit canAdd _item) then {
			_unit addMagazine _item;
		} else {
			hint format["Cant add item: %1\nSoldier: %2", _item, _unit];
			diag_log format["Cant add item: %1 \ Soldier: %2", _item, _unit];
		};
	};
};

fnc_a3ru_weap_equip = {
	private ["_unit", "_p_magz"];
	_unit = player;
	a3ru_weapon_closeCode = true;
	_unit setVariable ["WeaponTaken", true, true];

	////// REMOVE ALL ITEMS EXCEPT BI RADIO / TFAR RADIOS //////
	{
		if ((getText (configFile >> "CfgWeapons" >> _x >> "Simulation") != "ItemRadio") && _x != "tf_microdagr") then {
			_unit unassignItem _x;
			_unit removeItem _x;
		};
	}
	forEach ((assignedItems _unit) + (items _unit));
	
	
	////// BACKPACK //////
	_bp_count = count a3ru_w_back;
	_bp_index = a3ru_weapvar select 6;
	if (_bp_count > 1 && _bp_index != _bp_count - 1) then {
		_unit addBackpack (a3ru_w_back select _bp_index);
	};

	////// PRIMARY //////
	_p_count = count a3ru_w_primary;
	if (_p_count > 1) then {
		_p_index = a3ru_weapvar select 0;
		if (_p_index != _p_count - 1) then {
			_unit addWeapon (a3ru_w_primary select _p_index);
			if (count a3ru_w_primary_mag <= _p_index) then {
				_p_magz = a3ru_w_primary_mag select 0;
			} else {
				_p_magz = a3ru_w_primary_mag select _p_index;
			};
			{
				[_unit, _x] call fnc_a3ru_weap_canAddMagazines;
			} forEach _p_magz;
			_p_m1_count = count a3ru_w_mod1;
			_p_m1_index = a3ru_weapvar select 1;
			if (_p_m1_count > 1 && _p_m1_index != _p_m1_count - 1) then {
				_unit addPrimaryWeaponItem (a3ru_w_mod1 select _p_m1_index);
			};
			_p_m2_count = count a3ru_w_mod2;
			_p_m2_index = a3ru_weapvar select 2;
			if (_p_m2_count > 1 && _p_m2_index != _p_m2_count - 1) then {
				_unit addPrimaryWeaponItem (a3ru_w_mod2 select _p_m2_index);
			};
			_p_m3_count = count a3ru_w_mod3;
			_p_m3_index = a3ru_weapvar select 3;
			if (_p_m3_count > 1 && _p_m3_index != _p_m3_count - 1) then {
				_unit addPrimaryWeaponItem (a3ru_w_mod3 select _p_m3_index);
			};
		};
	};

	////// SECONDARY //////
	_s_count = count a3ru_w_secondary;
	_s_index = a3ru_weapvar select 4;
	if (_s_count > 1 && _s_index != _s_count - 1) then {
		_unit addWeapon (a3ru_w_secondary select _s_index);
		_s_magz = a3ru_w_secondary_mag select _s_index;
		{
			[_unit, [_x select 0, _x select 1]] call fnc_a3ru_weap_canAddMagazines;
		} forEach _s_magz;
	};
	{ _unit addSecondaryWeaponItem _x } forEach a3ru_w_secondary_mods;

	////// SIDEARM //////
	_side_count = count a3ru_w_side;
	_side_index = a3ru_weapvar select 5;
	if (_side_count > 1 && _side_index != _side_count - 1) then {
		_unit addWeapon (a3ru_w_side select _side_index);
		_side_magz = a3ru_w_side_mag select _side_index;
		{
			[_unit, _x] call fnc_a3ru_weap_canAddMagazines;
		} forEach _side_magz;
	};
	
	/// ALWAYS IN LOWER REGISTER!!! ///
	_itemsAsWeapons = ["binocular", "rangefinder", "agm_vector"];
	_noLinkItems = [
		"toolkit",
		// CSE
		"cse_morphine",
		"cse_epinephrine",
		"cse_packing_bandage",
		"cse_bandage_basic",
		"cse_bandageElastic",
		"cse_quikclot",
		"cse_tourniquet",
		"cse_saline_iv",
		"cse_nasopharyngeal_tube",
		"cse_atropine",
		"cse_personal_aid_kit",
		// AGM
		"agm_morphine",
		"agm_bandage",
		"agm_bloodbag",
		"agm_epipen",
		"agm_earbuds",
		"agm_sparebarrel",
		"agm_maptools",
		"agm_clacker",
		"agm_defusalkit",
		"agm_m26_clacker",
		"agm_m84",
		"agm_itemkestrel",
		"agm_handflare_green",
		"agm_handflare_red",
		"agm_handflare_white",
		"agm_handflare_yellow",
		"agm_cabletie",
		"agm_uavbattery"
	];
	_nvGoggles = ["nvgoggles", "nvgoggles_opfor", "nvgoggles_indep"];

	{
		if (typeName _x == "ARRAY") then {
			_item = ToLower (_x select 0);
			_amount = _x select 1;
			for "_i" from 1 to _amount do {
				if (_item in _itemsAsWeapons) then {
					_unit addWeapon _item;
				} else {
					if (_item in _nvGoggles) then {
						_time = ((date select 3) * 60) + (date select 4);
						_daytimeNVG = getNumber (MissionConfigFile >> "A3A_MissionParams" >> "daytimeNVG");
						if ((_time >= 1080 || _time <= 270) || (_daytimeNVG == 1)) then {
							_unit linkItem _item;
						} else {
							_unit addItem _item;
						};
					} else {
						if (_item in _noLinkItems) then {
							if (_unit CanAdd _item) then {
								_unit addItem _item;
							} else {
								hint format["Cant add item: %1\nSoldier: %2", _item, _unit];
								diag_log format["Cant add item: %1\nSoldier: %2", _item, _unit];
							};
						} else {
							_unit linkItem _item;
						};
					};
				};
			};
		} else {
			if (ToLower _x in _itemsAsWeapons) then {
				_unit addWeapon _x;
			} else {
				if (ToLower _x in _nvGoggles) then {
					_time = ((date select 3) * 60) + (date select 4);
					_daytimeNVG = getNumber (MissionConfigFile >> "A3A_MissionParams" >> "daytimeNVG");
					if ((_time >= 1080 || _time <= 270) || (_daytimeNVG == 1)) then {
						_unit linkItem _x;
					} else {
						_unit addItem _x;
					};
				} else {
					if (toLower _x in _noLinkItems) then {
						if (_unit CanAdd _x) then {
							_unit addItem _x;
						} else {
							hint format["Cant add item: %1\nSoldier: %2", _x, _unit];
							diag_log format["Cant add item: %1\nSoldier: %2", _x, _unit];
						};
					} else {
						_unit linkItem _x;
					};
				};
			};
		};
	} forEach a3ru_w_items;

	///////////////// END OF ADD/REMOVE ITEMS ///////////////
};

_a3ru_weap_dialog = {
	disableSerialization;
	if (!(createDialog "A3RU_WEAPON_HUD")) exitWith {
		hint "Dialog Error!\nPlease Rejoin!";
	};
	_display = findDisplay 1350;
	a3ru_weapvar = [0, 0, 0, 0, 0, 0, 0];

	{ ctrlEnable [_x, false] } forEach [1600, 1601, 1602, 1605, 1603, 1606, 1604, 1607, 1400, 1401, 1402, 1403]; // Disable RscEdit
	
	if (count a3ru_w_primary > 1) then {
		ctrlSetText [1200, getText (ConfigFile >> "CfgWeapons" >> a3ru_w_primary select 0 >> "picture")];
		_p_name = getText (ConfigFile >> "CfgWeapons" >> a3ru_w_primary select 0 >> "displayName");
		(_display displayCtrl 1200) ctrlSetTooltip _p_name;
		ctrlSetText [1400, _p_name];
		buttonSetAction [1600, "[0, 0] spawn fnc_a3ru_weap_iter;"];
		buttonSetAction [1601, "[1, 0] spawn fnc_a3ru_weap_iter;"];
		ctrlEnable [1600, true];
		ctrlEnable [1601, true];
		
		if (count a3ru_w_mod1 > 1) then {
			ctrlSetText [1201, getText (ConfigFile >> "CfgWeapons" >> a3ru_w_mod1 select 0 >> "picture")];
			_p_name = getText (ConfigFile >> "CfgWeapons" >> a3ru_w_mod1 select 0 >> "displayName");
			(_display displayCtrl 1201) ctrlSetTooltip _p_name;
			buttonSetAction [1602, "[0, 1] spawn fnc_a3ru_weap_iter;"];
			buttonSetAction [1605, "[1, 1] spawn fnc_a3ru_weap_iter;"];
			ctrlEnable [1602, true];
			ctrlEnable [1605, true];
		} else {
			ctrlSetText [1201, "A3A_Core\RESOURCES\a3a_empty.paa"];
		};
		if (count a3ru_w_mod2 > 1) then {
			ctrlSetText [1202, getText (ConfigFile >> "CfgWeapons" >> a3ru_w_mod2 select 0 >> "picture")];
			_p_name = getText (ConfigFile >> "CfgWeapons" >> a3ru_w_mod2 select 0 >> "displayName");
			(_display displayCtrl 1202) ctrlSetTooltip _p_name;
			buttonSetAction [1603, "[0, 2] spawn fnc_a3ru_weap_iter;"];
			buttonSetAction [1606, "[1, 2] spawn fnc_a3ru_weap_iter;"];
			ctrlEnable [1603, true];
			ctrlEnable [1606, true];
		} else {
			ctrlSetText [1202, "A3A_Core\RESOURCES\a3a_empty.paa"];
		};
		if (count a3ru_w_mod3 > 1) then {
			ctrlSetText [1203, getText (ConfigFile >> "CfgWeapons" >> a3ru_w_mod3 select 0 >> "picture")];
			_p_name = getText (ConfigFile >> "CfgWeapons" >> a3ru_w_mod3 select 0 >> "displayName");
			(_display displayCtrl 1203) ctrlSetTooltip _p_name;
			buttonSetAction [1604, "[0, 3] spawn fnc_a3ru_weap_iter;"];
			buttonSetAction [1607, "[1, 3] spawn fnc_a3ru_weap_iter;"];
			ctrlEnable [1604, true];
			ctrlEnable [1607, true];
		} else {
			ctrlSetText [1203, "A3A_Core\RESOURCES\a3a_empty.paa"];
		};
	} else {
		ctrlSetText [1200, "A3A_Core\RESOURCES\a3a_empty.paa"];
		ctrlSetText [1400, localize "STR_A3RU_weap_noweap"];
	};

	{ ctrlEnable [_x, false] } forEach [1608, 1609, 1401]; // Disable RscEdit

	if (count a3ru_w_secondary > 1) then {
		ctrlSetText [1204, getText (ConfigFile >> "CfgWeapons" >> a3ru_w_secondary select 0 >> "picture")];
		_p_name = getText (ConfigFile >> "CfgWeapons" >> a3ru_w_secondary select 0 >> "displayName");
		(_display displayCtrl 1204) ctrlSetTooltip _p_name;
		ctrlSetText [1401, _p_name];
		buttonSetAction [1608, "[0, 4] spawn fnc_a3ru_weap_iter;"];
		buttonSetAction [1609, "[1, 4] spawn fnc_a3ru_weap_iter;"];
		ctrlEnable [1608, true];
		ctrlEnable [1609, true];
	} else {
		ctrlSetText [1204, "A3A_Core\RESOURCES\a3a_empty.paa"];
		ctrlSetText [1401, localize "STR_A3RU_weap_noweap"];
	};

	{ ctrlEnable [_x, false] } forEach [1610, 1611, 1402]; // Disable RscEdit

	if (count a3ru_w_side > 1) then {
		ctrlSetText [1205, getText (ConfigFile >> "CfgWeapons" >> a3ru_w_side select 0 >> "picture")];
		_p_name = getText (ConfigFile >> "CfgWeapons" >> a3ru_w_side select 0 >> "displayName");
		(_display displayCtrl 1205) ctrlSetTooltip _p_name;
		ctrlSetText [1402, _p_name];
		buttonSetAction [1610, "[0, 5] spawn fnc_a3ru_weap_iter;"];
		buttonSetAction [1611, "[1, 5] spawn fnc_a3ru_weap_iter;"];
		ctrlEnable [1610, true];
		ctrlEnable [1611, true];
	} else {
		ctrlSetText [1205, "A3A_Core\RESOURCES\a3a_empty.paa"];
		ctrlSetText [1402, localize "STR_A3RU_weap_noweap"];
	};

	{ ctrlEnable [_x, false] } forEach [1613, 1612, 1402]; // Disable RscEdit

	if (count a3ru_w_back > 1) then {
		ctrlSetText [1206, getText (ConfigFile >> "CfgVehicles" >> a3ru_w_back select 0 >> "picture")];
		_b_name = getText (ConfigFile >> "CfgVehicles" >> a3ru_w_back select 0 >> "displayName");
		_b_load = getNumber (ConfigFile >> "CfgVehicles" >> a3ru_w_back select 0 >> "maximumload");
		(_display displayCtrl 1206) ctrlSetTooltip _b_name;
		ctrlSetText [1403, format["%1 \ %2", _b_name, _b_load]];
		buttonSetAction [1613, "[0, 6] spawn fnc_a3ru_weap_iter;"];
		buttonSetAction [1612, "[1, 6] spawn fnc_a3ru_weap_iter;"];
		ctrlEnable [1613, true];
		ctrlEnable [1612, true];
	} else {
		ctrlSetText [1206, "A3A_Core\RESOURCES\a3a_empty.paa"];
		ctrlSetText [1403, localize "STR_A3RU_weap_noweap"];
	};
	
	buttonSetAction [1614, "closeDialog 0; [] call fnc_a3ru_weap_equip;"];
};

a3ru_weapon_closeCode = false;
if ((getNumber (MissionConfigFile >> "A3A_MissionParams" >> "equipmentDialog")) == 1) then {
	while {!a3ru_weapon_closeCode} do {
		call _a3ru_weap_dialog;
		waitUntil { sleep 0.5; !dialog };
	};
} else {
	a3ru_weapvar = [0, 0, 0, 0, 0, 0, 0];
	[] call fnc_a3ru_weap_equip;
};

/// CLEAR VARIABLES ///
a3ru_weapon_closeCode = nil;
a3ru_w_primary = nil;
a3ru_w_primary_mag = nil;
a3ru_w_mod1 = nil;
a3ru_w_mod2 = nil;
a3ru_w_mod3 = nil;
a3ru_w_secondary = nil;
a3ru_w_secondary_mag = nil;
a3ru_w_side = nil;
a3ru_w_side_mag = nil;
a3ru_w_items = nil;
a3ru_w_back = nil;
fnc_a3ru_weap_canAddMagazines = nil;
fnc_a3ru_weap_iter = nil;
fnc_a3ru_weap_equip = nil;