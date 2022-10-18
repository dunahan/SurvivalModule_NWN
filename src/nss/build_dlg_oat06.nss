#include "build_util_inc"
string script = "build_dlg_oat06";

void main()
{
  object oWorkbench = OBJECT_SELF;
  int nRow =  6, nToken = 506, nPage = GetLocalInt(oWorkbench, "BUILD_ActPage");    //at which page are we?
  nRow = nRow + BUILD_CalcReciepeToken(nPage);

  SetLocalInt(oWorkbench, "BUILD_RecipeChoosen", nRow);
}
