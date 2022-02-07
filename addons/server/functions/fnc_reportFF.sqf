#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Reports friendly fire incident
 */

params ["_victim", "_shooter", "_ammoType"];
TRACE_3("reportFF",_victim,_shooter,_ammoType);

if !(isServer) exitWith {};

// TODO: Replace with callExtension
diag_log format [
  "Gracz %1 zostal trafiony przez %2 (%3)",
  _victim call ACEFUNC(common,getName),
  _shooter call ACEFUNC(common,getName),
  _ammoType
];
