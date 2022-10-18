#include "build_util_inc"
string script = "build_dlg_taw13";

int StartingConditional()
{
  return BUILD_IsRecipePossibleToBuild(GetPCSpeaker(), OBJECT_SELF, GetLocalInt(OBJECT_SELF, "BUILD_RecipeChoosen"));
}
