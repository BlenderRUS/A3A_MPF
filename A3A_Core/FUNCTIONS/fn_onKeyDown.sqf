if !(alive player) exitWith {
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", a3a_UI_DEH];
};

_key     = _this select 1;
_shift   = _this select 2;
_ctrl	= _this select 3;
_alt	= _this select 4;
_handled = false;

// ---------------------------- Atrium UI Menu ----------------------------
if ([_key, _shift, _ctrl, _alt] isEqualTo a3a_var_key_interactionMenu) then {
	if (!dialog) then {
		createDialog "A3RU_POPUP_UI";
		_display = uiNamespace getVariable "A3RU_POPUP_UI";
		_controls = [1702, 1703, 1704, 1705, 1706, 1707, 1708, 1709, 1710];
		_selectedCtrl = 0;
		
		{ ctrlShow [_x, false] } forEach _controls;
		if (count a3a_UI_array == 0) then {
			ctrlShow [1702, true];
			ctrlEnable [1702, false];
			ctrlSetText [1702, "No actions"];
		} else {
			{
				if (_selectedCtrl > 8) exitWith {};
				_ctrl = _controls select _selectedCtrl;
				
				_UI_text = _x select 0;
				_UI_args = _x select 1;
				_UI_func = _x select 2;
				_UI_requ = _x select 3;
				if (call compile _UI_requ) then {
					_selectedCtrl = _selectedCtrl + 1;
					ctrlShow [_ctrl, true];
					ctrlSetText [_ctrl, _UI_text];
					buttonSetAction [_ctrl, format["closeDialog 0; %1 spawn %2;", _UI_args, _UI_func]];
				};
			} forEach a3a_UI_array;
		};
	} else {
		closeDialog 0;
	};
	_handled = true;
};
// **************************** Atrium UI Menu ****************************

_handled