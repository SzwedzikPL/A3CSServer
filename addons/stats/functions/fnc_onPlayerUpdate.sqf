#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Handles playerUpdate event
 */
params ["_uid", "_dist", "_bullets", "_grenades"];
TRACE_4("onPlayerUpdate",_uid,_dist,_bullets,_grenades);

private _stats = GVAR(stats) get _uid;
if (isNil "_stats") exitWith {};

_stats set ["distTrav", (_stats get "distTrav") + _dist];
_stats set ["bullets", (_stats get "bullets") + _bullets];
_stats set ["grenades", (_stats get "grenades") + _grenades];
