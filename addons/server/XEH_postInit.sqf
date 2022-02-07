#include "script_component.hpp"

if !(isServer) exitWith {};

// If callExtension return exit

[QGVAR(reportFF), {
  _this call FUNC(reportFF);
}] call CBA_fnc_addEventHandler;
