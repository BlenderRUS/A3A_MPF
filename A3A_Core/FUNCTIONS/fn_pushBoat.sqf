// Push Boat function
_target = cursorTarget;

if !(isNull _target) then {
	if ((_target isKindOf "ship") && player distance _target < 7) then {
		if ({isPlayer _x} count (crew _target) > 0) exitWith {
			hint parseText '<t color="#ff0000"><img image="\a3\ui_f\data\gui\cfg\cursors\hc_unsel_gs.paa"/></t> Boat should be <t color="#FFFF33">empty</t>!';
		};
		_dir = getDir player;
		_target setVelocity [sin(_dir), cos(_dir), 1.5];
	};
};