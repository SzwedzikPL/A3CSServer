#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Cuts string for DB length (255 chars)
 */

params ["_string"];

if ((count _string) > 255) then {
  _string = (_string select [0, 252]) + "...";
};

_string
