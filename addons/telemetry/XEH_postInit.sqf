#include "script_component.hpp"

0 spawn {
  sleep 0.001;

  [{
    private _fps = GVAR(fpsData);
    _fps pushBack (floor diag_fps);
    if (count _fps > 30) then {_fps deleteAt 0;};

    private _fpsMin = GVAR(fpsMinData);
    _fpsMin pushBack (floor diag_fpsMin);
    if (count _fpsMin > 30) then {_fpsMin deleteAt 0;};
  }, 1] call CBA_fnc_addPerFrameHandler;

  [{
    0 spawn FUNC(sendTelemetry);
  }, 30] call CBA_fnc_addPerFrameHandler;
};
