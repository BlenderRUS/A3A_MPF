disableSerialization;

#define c_blue [0, 0.4, 1, 1]
#define c_red [0.8, 0.2, 0, 1]
#define c_grey [0.33, 0.33, 0.33, 1]
#define c_yellow [1, 1, 0.87, 1]

// Types:
// 0 - Blue seizing
// 1 - Red seizing
// 2 - Equal forces Blue sup
// 3 - Equal forces Red sup
// 4 - Blue holding
// 5 - Red holding
// 6 - Blue returning
// 7 - Red returning
_type = _this select 0;
_progress = _this select 1;
_pos = _this select 2;
_area = _this select 3;

if ((player distance _pos) <= _area) then {

	if (_progress < 0) then { _progress = 0 };
	if (_progress > 10) then { _progress = 10 };

	titleRsc ["A3RU_PROGRESS_UI","PLAIN",0];
	_display = uiNamespace getVariable "A3RU_PROGRESS_UI";

	_controls = [1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810];

	switch (_type) do {
		case 0: {
			{ (_display displayCtrl _x) ctrlEnable false } forEach _controls;
			for "_i" from 0 to (_progress - 1) do {
				_control = (_display displayCtrl (_controls select _i));
				_control ctrlEnable true;
				_control ctrlSetTextColor c_blue;
			};
			(_display displayCtrl 1811) ctrlSetText "Запад захватывает зону"
		};
		case 1: {
			{ (_display displayCtrl _x) ctrlEnable false } forEach _controls;
			for "_i" from 0 to (_progress - 1) do {
				_control = (_display displayCtrl (_controls select _i));
				_control ctrlEnable true;
				_control ctrlSetTextColor c_red;
			};
			(_display displayCtrl 1811) ctrlSetText "Восток захватывает зону"
		};
		case 2: {
			{ (_display displayCtrl _x) ctrlEnable false } forEach _controls;
			for "_i" from 0 to (_progress - 1) do {
				_control = (_display displayCtrl (_controls select _i));
				_control ctrlEnable true;
				_control ctrlSetTextColor c_blue;
			};
			(_display displayCtrl 1811) ctrlSetText "Равное количество в зоне"
		};
		case 3: {
			{ (_display displayCtrl _x) ctrlEnable false } forEach _controls;
			for "_i" from 0 to (_progress - 1) do {
				_control = (_display displayCtrl (_controls select _i));
				_control ctrlEnable true;
				_control ctrlSetTextColor c_red;
			};
			(_display displayCtrl 1811) ctrlSetText "Равное количество в зоне"
		};
		case 4: {
			{ (_display displayCtrl _x) ctrlEnable false } forEach _controls;
			for "_i" from 0 to (_progress - 1) do {
				_control = (_display displayCtrl (_controls select _i));
				_control ctrlEnable true;
				_control ctrlSetTextColor c_grey;
			};
			(_display displayCtrl 1811) ctrlSetText "Равное количество в зоне"
		};
		case 5: {
			{
				_control = _display displayCtrl _x;
				_control ctrlEnable true;
				
				if (_forEachIndex <= (_progress - 1)) then {
					_control ctrlSetTextColor c_yellow;
				} else {
					_control ctrlSetTextColor c_blue;
				};
			} forEach _controls;
			(_display displayCtrl 1811) ctrlSetText "Запад удерживает зону"
		};
		case 6: {
			{
				_control = _display displayCtrl _x;
				_control ctrlEnable true;
				
				if (_forEachIndex < (_progress - 1)) then {
					_control ctrlSetTextColor c_yellow;
				} else {
					_control ctrlSetTextColor c_red;
				};
			} forEach _controls;
			(_display displayCtrl 1811) ctrlSetText "Восток удерживает зону"
		};
		case 7: {
			{ (_display displayCtrl _x) ctrlEnable false } forEach _controls;
			for "_i" from 0 to (_progress - 1) do {
				_control = (_display displayCtrl (_controls select _i));
				_control ctrlEnable true;
				_control ctrlSetTextColor c_red;
			};
			(_display displayCtrl 1811) ctrlSetText "Запад захватывает зону"
		};
		case 8: {
			{ (_display displayCtrl _x) ctrlEnable false } forEach _controls;
			for "_i" from 0 to (_progress - 1) do {
				_control = (_display displayCtrl (_controls select _i));
				_control ctrlEnable true;
				_control ctrlSetTextColor c_blue;
			};
			(_display displayCtrl 1811) ctrlSetText "Восток захватывает зону"
		};
	};
};