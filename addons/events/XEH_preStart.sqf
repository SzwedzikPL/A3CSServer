#include "script_component.hpp"

#include "XEH_PREP.hpp"

"a3csserver" callExtension ["srvPreStart", [
  format ["%1.%2", ((productVersion # 2)/100) toFixed 2, (productVersion # 3)]
]];
0 call FUNC(observeClientState);
