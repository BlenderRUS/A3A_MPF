// Project: ArmA 3 Atrium Framework
// Author: Blender
// E-mail: blender@arma3.ru
// Specially for ARMA3.RU Community: http://www.arma3.ru

private ["_startRating", "_ratingDiff"];
_startRating = rating player;
if (_startRating < 0) then { _startRating = 0 };

while {alive player} do {
	_ratingDiff = rating player - _startRating;
	if (_ratingDiff != 0) then {
		player addRating -_ratingDiff
	};
	sleep 10.217;
};