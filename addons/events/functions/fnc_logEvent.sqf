#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Sends event data to website logs
 */

params ["_type", "_params"];
_params insert [0, [floor CBA_missionTime]];
TRACE_2("logEvent",_type,_params);

if !(isServer) exitWith {};

"a3csserver" callExtension [_type, _params];
