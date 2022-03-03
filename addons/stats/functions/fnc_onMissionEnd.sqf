#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Handles mission ended event
 */
LOG("onMissionEnd");

// Exit if mission already ended - no double events
if (GVAR(missionEnded)) exitWith {
  LOG("Mission already ended - skip.");
};
GVAR(missionEnded) = true;

private _mission = EGVAR(common,missionName);

{
  TRACE_1("sending userEndStats",_x);
  private _playTime = _y get "playTime";
  if (_y get "playing") then {
    _playTime = _playTime + (CBA_missionTime - (_y get "conTime"));
  };

  "a3csserver" callExtension ["userEndStats", [
    _y get "name",
    _x,
    _mission,
    _playTime,
    _y get "distTrav",
    _y get "bullets",
    _y get "grenades",
    _y get "killsB",
    _y get "killsO",
    _y get "killsI",
    _y get "killsC",
    _y get "uncons",
    _y get "deaths"
  ]];
} forEach GVAR(stats);
