#include "build_util_inc"
string script = "build_dlg_oat05";

void main()
{
  object oWorkbench = OBJECT_SELF;
  int nRow =  5, nToken = 505, nPage = GetLocalInt(oWorkbench, "BUILD_ActPage");    //at which page are we?
  nRow = nRow + BUILD_CalcReciepeToken(nPage);

  SetLocalInt(oWorkbench, "BUILD_RecipeChoosen", nRow);
}
