#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

GVAR(stats) = createHashMap;

addMissionEventHandler ["PlayerConnected", {
  _this call FUNC(onPlayerConnected);
}];

addMissionEventHandler ["PlayerDisconnected", {
  _this call FUNC(onPlayerDisconnected);
}];

ADDON = true;
