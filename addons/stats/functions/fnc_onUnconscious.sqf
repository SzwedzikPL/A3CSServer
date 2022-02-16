#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Handles ace_unconscious event
 */
params ["_unit", "_active"];
TRACE_2("onUnconscious",_unit,_active);

if !(_active && {_unit getVariable ["a3cs_common_isPlayer", false]}) exitWith {
  LOG("onUnconscious: Not player - skip.");
};

private _uid = _unit getVariable ["a3cs_common_UID", ""];
private _stats = GVAR(stats) get _uid;

if (isNil "_stats") exitWith {};
_stats set ["uncons", (_stats get "uncons") + 1];
