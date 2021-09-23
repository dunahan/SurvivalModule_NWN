#include "build_util_inc"

void main()
{
  DelayCommand(BUILD_WAIT_REUSE, SetPlotFlag(OBJECT_SELF, FALSE));

  SetEventScript(OBJECT_SELF, EVENT_SCRIPT_PLACEABLE_ON_HEARTBEAT, "");
}
