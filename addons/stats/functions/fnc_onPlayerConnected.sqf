#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Handles PlayerConnected event
 */

params ["_id", "_uid", "_name"];
TRACE_3("onPlayerConnected",_id,_uid,_name);

if ((_id == 2) || {(_uid select [0, 2]) == "hc"}) exitWith {};

private _stats = GVAR(stats) get _uid;

// Create new hashmap if not preset for this player
if (isNil "_stats") then {
  _stats = createHashMap;
  _stats set ["name", _name];
  _stats set ["playTime", 0];
  _stats set ["distTrav", 0];
  _stats set ["bullets", 0];
  _stats set ["grenades", 0];
  _stats set ["killsB", 0];
  _stats set ["killsO", 0];
  _stats set ["killsI", 0];
  _stats set ["killsC", 0];
  _stats set ["uncons", 0];
  _stats set ["deaths", 0];
};

_stats set ["playing", true];
_stats set ["conTime", CBA_missionTime];
GVAR(stats) set [_uid, _stats];
