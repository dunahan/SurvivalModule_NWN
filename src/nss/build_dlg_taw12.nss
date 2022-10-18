#include "build_util_inc"
string script = "build_dlg_taw12";

int StartingConditional()
{
  if (GetLocalInt(OBJECT_SELF, "BUILD_ActPage") > 1 &&                           //actual page is greater 1 AND
      GetLocalInt(OBJECT_SELF, "BUILD_ActPage") <= GetLocalInt(OBJECT_SELF, "BUILD_Pages")) //the acual page is smaller or equal to all pages in the book
    return TRUE;
  return FALSE;
}
