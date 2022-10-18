#include "build_util_inc"
string script = "build_dlg_oat11";

void main()
{
  if (GetLocalInt(OBJECT_SELF, "BUILD_ActPage") < GetLocalInt(OBJECT_SELF, "BUILD_Pages"))    //only add if end of book not reached
    SetLocalInt(OBJECT_SELF, "BUILD_ActPage", GetLocalInt(OBJECT_SELF, "BUILD_ActPage")+1);
}
