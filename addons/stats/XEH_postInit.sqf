#include "script_component.hpp"

GVAR(missionEnded) = false;

[QGVAR(updatePlayer), {
  _this call FUNC(onPlayerUpdate);
}] call CBA_fnc_addEventHandler;

["ace_killed", {
  _this call FUNC(onKilled);
}] call CBA_fnc_addEventHandler;

["ace_unconscious", {
  _this call FUNC(onUnconscious);
}] call CBA_fnc_addEventHandler;

addMissionEventHandler ["Ended", {
  TRACE_1("Ended",_this);
  0 call FUNC(onMissionEnd);
}];

addMissionEventHandler ["MPEnded", {
  LOG("MPEnded");
  0 call FUNC(onMissionEnd);
}];

["a3cs_missionEnded", {
  LOG("a3cs_missionEnded");
  0 call FUNC(onMissionEnd);
}] call CBA_fnc_addEventHandler;
