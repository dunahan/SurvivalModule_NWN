#include "build_util_inc"
string script = "build_dlg_taw06";

int StartingConditional()
{
  object oWorkbench = OBJECT_SELF, oCrafter = GetPCSpeaker();
  int nRow =  6, nToken = 506, nPage = GetLocalInt(oWorkbench, "BUILD_ActPage");    //at which page are we?
  nRow = nRow + BUILD_CalcReciepeToken(nPage);

  if (nRow > BUILD_MAXRECI_PG)
    return FALSE;

  if (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME003, nRow) != "")
  {
    SetCustomToken(nToken, BUILD_CreateRecipeLabel(nRow));
    SetCustomToken(nToken+100, BUILD_CreateRecipeText(nRow, oCrafter));

    return TRUE;
  }
  return FALSE;
}
