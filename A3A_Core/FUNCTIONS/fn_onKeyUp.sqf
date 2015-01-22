private["_key", "_shift", "_ctrl", "_alt", "_handled"];

_key     = _this select 1;
_shift   = _this select 2;
_ctrl	= _this select 3;
_alt	= _this select 4;
_handled = false;

if (_ctrl) then { a3ru_var_static_rotate = false };

_handled