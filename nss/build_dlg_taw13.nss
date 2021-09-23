#include "build_util_inc"

int StartingConditional()
{
  return BUILD_IsRecipePossibleToBuild(GetPCSpeaker(), OBJECT_SELF, GetLocalInt(OBJECT_SELF, "BUILD_RecipeChoosen"));
}
