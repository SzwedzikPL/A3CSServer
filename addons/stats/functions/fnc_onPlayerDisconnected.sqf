#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Handles PlayerDisconnected event
 */
params ["", "_uid"];
TRACE_1("onPlayerDisconnected",_uid);

private _stats = GVAR(stats) get _uid;
if (isNil "_stats") exitWith {};

_stats set ["playing", false];
_stats set ["playTime", (CBA_missionTime - (_stats get "conTime")) + (_stats get "playTime")];
