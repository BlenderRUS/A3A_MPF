// Message Broadcast
// a3a_fnc_message
// Syntax: [Message, TypeOf Message, Side]
// Message - your message
// TypeOf Message can be 0, 1, 2 or 3.
// 0 - displays Successfully completed task
// 1 - Failed task
// 2 - Assigned task
// 3 - Canceled task
// More info on BIKI: http://community.bistudio.com/wiki/Notification
// Side - side which receive this message. If no side is specified - everyone will receive the message
// For example:
// ["Victory!", 0, EAST] call a3a_fnc_message;
// ["VIP is dead!", 1] call a3a_fnc_message;

if (count _this > 2) then {
	a3a_var_broadCast = [_this select 0, _this select 1, _this select 2];
	if (!isDedicated) then { [_this select 0, _this select 1, _this select 2] call a3a_fnc_getMessage };
} else {
	a3a_var_broadCast = [_this select 0, _this select 1];
	if (!isDedicated) then { [_this select 0, _this select 1] call a3a_fnc_getMessage };
};
publicVariable "a3a_var_broadCast";