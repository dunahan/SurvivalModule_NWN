#include "build_util_inc"
string script = "build_workb_ocl";

void main()
{
  if (GetIsObjectValid(GetFirstItemInInventory()))
  {
    SetLocalInt(OBJECT_SELF, "BUILD_ActPage", 1);                                //starting page
    ActionStartConversation(GetLastClosedBy(), "build_dlg_workb", TRUE, FALSE);  //start convo
  }
}
