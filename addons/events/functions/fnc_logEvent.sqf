#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Sends event data to website logs
 */

params ["_type", "_params"];
TRACE_2("logEvent",_type,_params);

if !(isServer) exitWith {};

"a3csserver" callExtension [_type, _params];
