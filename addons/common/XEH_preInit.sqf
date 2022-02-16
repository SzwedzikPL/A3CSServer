#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

GVAR(missionName) = briefingName call EFUNC(common,cutStrForDb);
if (GVAR(missionName) == "") then {
  GVAR(missionName) = missionName call EFUNC(common,cutStrForDb);
};
TRACE_1("missionName",GVAR(missionName));

ADDON = true;
