#include "build_util_inc"

int StartingConditional()
{
  if (GetLocalInt(OBJECT_SELF, "ICNR_ActPage") >= 1 &&                          //actual page is equal 1 or greater AND
      GetLocalInt(OBJECT_SELF, "ICNR_ActPage") < GetLocalInt(OBJECT_SELF, "ICNR_Pages")) //tha acual page is smaller compaired to all pages in the book
    return TRUE;
  return FALSE;
}
