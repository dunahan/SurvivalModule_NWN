#include "build_util_inc"
string script = "build_dlg_oat08";

void main()
{
  object oWorkbench = OBJECT_SELF;
  int nRow =  8, nToken = 508, nPage = GetLocalInt(oWorkbench, "BUILD_ActPage");    //at which page are we?
  nRow = nRow + BUILD_CalcReciepeToken(nPage);

  SetLocalInt(oWorkbench, "BUILD_RecipeChoosen", nRow);
}
