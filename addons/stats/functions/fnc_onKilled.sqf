#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Handles ace killed event
 */
params ["_unit", "", "", "_instigator"];
TRACE_2("onKilled",_unit,_instigator);

// Increment deaths if killed unit is player
if (_unit getVariable ["a3cs_common_isPlayer", false]) then {
  private _stats = GVAR(stats) get (_unit getVariable ["a3cs_common_UID", ""]);
  if (isNil "_stats") exitWith {};
  _stats set ["deaths", (_stats get "deaths") + 1];
};

// Exit if instigator is not player or self-kill (sometimes result of ace medical scripting)
if (
  !(_instigator getVariable ["a3cs_common_isPlayer", false]) ||
  {_unit isEqualTo _instigator}
) exitWith {};

private _side = side (group _unit);
private _sideIndex = [west, east, independent, civilian] find _side;
if (_sideIndex == -1) exitWith {};

private _key = ["killsB", "killsO", "killsI", "killsC"] select _sideIndex;
private _stats = GVAR(stats) get (_instigator getVariable ["a3cs_common_UID", ""]);

if (isNil "_stats") exitWith {};
_stats set [_key, (_stats get _key) + 1];
