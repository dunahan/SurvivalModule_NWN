#include "build_util_inc"

void main()
{
  object oWorkbench = OBJECT_SELF;
  int nRow =  9, nToken = 509, nPage = GetLocalInt(oWorkbench, "BUILD_ActPage");    //at which page are we?
  nRow = nRow + BUILD_CalcReciepeToken(nPage);

  SetLocalInt(oWorkbench, "BUILD_RecipeChoosen", nRow);
}
