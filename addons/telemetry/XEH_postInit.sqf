#include "script_component.hpp"

0 spawn {
  sleep 0.001;

  [{
    // Ignore if client state not 10
    if (getClientStateNumber != 10) exitWith {};

    private _fps = GVAR(fpsData);
    _fps pushBack (floor diag_fps);

    private _fpsMin = GVAR(fpsMinData);
    _fpsMin pushBack (floor diag_fpsMin);
  }, 1] call CBA_fnc_addPerFrameHandler;

  [{
    // Ignore if client state not 10
    if (getClientStateNumber != 10) exitWith {};

    0 spawn FUNC(sendTelemetry);
  }, 30] call CBA_fnc_addPerFrameHandler;
};
