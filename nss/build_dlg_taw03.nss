#include "build_util_inc"

int StartingConditional()
{
  object oWorkbench = OBJECT_SELF, oCrafter = GetPCSpeaker();
  int nRow =  3, nToken = 503, nPage = GetLocalInt(oWorkbench, "ICNR_ActPage");    //at which page are we?
  nRow = nRow + ICNR_CalcReciepeToken(nPage);

//if (nRow > ICNR_MAXRECI_PG)
//  return FALSE;

  if (Get2DAString(GetTag(oWorkbench), "Lvl", nRow) != "")
  {
    SetCustomToken(nToken, ICNR_CreateRecipeLabel(nRow));
    SetCustomToken(nToken+100, ICNR_CreateRecipeText(nRow, oCrafter));

    return TRUE;
  }
  return FALSE;
}
