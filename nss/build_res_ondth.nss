#include "build_util_inc"

void main()
{
  object oPlc = CreateObject(OBJECT_TYPE_PLACEABLE, "build_spawner", GetLocation(OBJECT_SELF));

  SendMessageToPC(GetFirstPC(), BUILD_LANG_RES_NOTMORE);
}
