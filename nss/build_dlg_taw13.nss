#include "build_util_inc"

int StartingConditional()
{
  return ICNR_IsRecipePossibleToBuild(GetPCSpeaker(), OBJECT_SELF, GetLocalInt(OBJECT_SELF, "ICNR_RecipeChoosen"));
}
