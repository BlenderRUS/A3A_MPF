// Project: ArmA 3 Atrium Framework
// Author: Blender
// E-mail: blender@arma3.ru
// Specially for ARMA3.RU Community: http://www.arma3.ru

private ["_vehicleFreeze", "_vehicles", "_vehicle", "_eh", "_vehSide", "_veh", "_state"];

vehicles_engineEH = [];
if (isNil "a3a_var_noFreezeVehicles") then { a3a_var_noFreezeVehicles = [] };

while {!a3a_var_started} do {
	_vehicles = (position player) nearEntities [["Car", "Tank", "Air", "Boat"], 100];
	if (vehicle player != player) then { _vehicles SET [count _vehicles, vehicle player] };
	
	for "_i" from 0 to ((count _vehicles) - 1) do {
		_vehicle = _vehicles select _i;
		_eh = _vehicle getVariable "engineEH";
		if (isNil "_eh") then {
			if !(_vehicle in a3a_var_noFreezeVehicles) then {
				_eh = _vehicle addEventHandler ["Engine",
				{
					_veh = _this select 0;
					_state = _this select 1;
					if (local _veh && _state) then {
						player action ["engineoff", _veh];
					};
				}];
				_vehicle setVariable ["engineEH", _eh, false];
			} else {
				_vehicle setVariable ["engineEH", -1, false];
			};
			vehicles_engineEH SET [count vehicles_engineEH, _vehicle];
		};
	};
	sleep 5.127;
};

for "_i" from 0 to ((count vehicles_engineEH) - 1) do {
	_vehicle = vehicles_engineEH select _i;
	if !(isNull _vehicle) then {
		_eh = _vehicle getVariable ["engineEH", -1];
		if (_eh != -1) then {
			_vehicle removeEventHandler ["Engine", _eh];
		};
		_vehicle setVariable ["engineEH", nil, false];
	};
};

if (!isNil "a3a_var_forceVehiclesFreeze") then {
	vehicles_engineEH = [];
	
	for "_i" from 0 to ((count a3a_var_forceVehiclesFreeze) - 1) do {
		_vehicle = a3a_var_forceVehiclesFreeze select _i;
		_eh = _vehicle addEventHandler ["Engine",
		{
			_veh = _this select 0;
			_state = _this select 1;
			if (local _veh && _state) then {
				player action ["engineoff", _veh];
			};
		}];
		_vehicle setVariable ["engineEH", _eh, false];
		vehicles_engineEH SET [count vehicles_engineEH, _vehicle];
		if (local _vehicle) then {
			player action ["engineoff", _vehicle];
		};
	};
	while { true } do {
		for "_i" from 0 to ((count vehicles_engineEH) - 1) do {
			_vehicle = vehicles_engineEH select _i;
			if !(_vehicle in a3a_var_forceVehiclesFreeze) then {
				if !(isNull _vehicle) then {
					_eh = _vehicle getVariable ["engineEH", -1];
					if (_eh != -1) then {
						_vehicle removeEventHandler ["Engine", _eh];
					};
					_vehicle setVariable ["engineEH", nil, false];
				};
				vehicles_engineEH SET [_i, -1];
			};
		};
		vehicles_engineEH = vehicles_engineEH - [-1];
		if ((count a3a_var_forceVehiclesFreeze) == 0) exitWith {};
		sleep 1.219;
	};
};

vehicles_engineEH = nil;