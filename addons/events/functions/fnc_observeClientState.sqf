#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Sends user->target event log data
 */
LOG("observeClientState");

if !(isNil QGVAR(clientStateObserver)) exitWith {
  LOG("Client state already observed");
};

LOG("Observing client state");

// Start with 0 to avoid reporting 0 state - no client
GVAR(currentClientState) = 0;
GVAR(clientStateObserver) = addMissionEventHandler ["EachFrame", {
  if (getClientStateNumber != GVAR(currentClientState)) then {
    // 10 means mission started so we don't need it anymore
    // for mission start we have different event so no need for reporting number 10
    if (getClientStateNumber >= 10) exitWith {
      TRACE_1("Removing client state observer",getClientStateNumber);
      removeMissionEventHandler ["EachFrame", GVAR(clientStateObserver)];
    };
    GVAR(currentClientState) = getClientStateNumber;
    "a3csserver" callExtension ["srvStChanged", [getClientStateNumber]];
  };
}];
