#include "build_util_inc"

void main()
{
  object oWorkbench = OBJECT_SELF;
  int nRow =  4, nToken = 504, nPage = GetLocalInt(oWorkbench, "ICNR_ActPage");    //at which page are we?
  nRow = nRow + ICNR_CalcReciepeToken(nPage);

  SetLocalInt(oWorkbench, "ICNR_RecipeChoosen", nRow);
}