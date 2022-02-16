#include "script_component.hpp"

ADDON = false;

"a3csserver" callExtension "srvPreInit";

#include "XEH_PREP.hpp"

0 call FUNC(observeClientState);

ADDON = true;
