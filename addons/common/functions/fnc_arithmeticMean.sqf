#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Returns the arithmetic mean ("average value") of an array of numbers.
 */

private _ret = 0;
{_ret = _ret + _x} count _this;

_ret / count _this
