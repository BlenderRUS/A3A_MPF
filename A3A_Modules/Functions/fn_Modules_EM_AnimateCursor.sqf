disableSerialization;
private ["_ctrl", "_textArray", "_finalized", "_sleep", "_textEntry", "_image", "_text", "_format", "_break", "_tempText"];

_ctrl = _this select 0;
_textArray = _this select 1;
_finalized = "";
_sleep = 0.02;

for "_i" from 0 to ((count _textArray) - 1) do {
	_textEntry = _textArray select _i;

	_image = _textEntry select 0;
	_text = toArray (_textEntry select 1);
	_format = _textEntry select 2;
	_break = _textEntry select 3;
	
	if (_image != "") then {
		if (_format != "") then {
			_finalized = _finalized + format["<t %1><img %2/></t>", _format, _image];
		} else {
			_finalized = _finalized + format["<img %1/>", _image];
		};
		_ctrl ctrlSetStructuredText (parseText _finalized);
		sleep _sleep;
	};
	
	if (count _text > 0) then {
		_tempText = "";
		/// DISPLAY
		{
			_key = toString [_x];
			_tempText = _tempText + _key;
			if (_format != "") then {
				_ctrl ctrlSetStructuredText parseText format["%1<t %2>%3</t>", _finalized, _format, _tempText];
			} else {
				_ctrl ctrlSetStructuredText parseText (_finalized + _tempText);
			};
			sleep _sleep;
		} forEach _text;

		/// FINALIZE
		if (_format != "") then {
			_finalized = _finalized + format["<t %1>%2</t>", _format, _tempText];
		} else {
			_finalized = _finalized + _tempText;
		};
	};
	
	if (_break) then {
		_finalized = _finalized + "<br/>";
	};		
};