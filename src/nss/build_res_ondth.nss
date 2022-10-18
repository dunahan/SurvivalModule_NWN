#include "build_util_inc"
string script = "build_res_ondth";

void main()
{
  object oPlc = CreateObject(OBJECT_TYPE_PLACEABLE, "build_spawner", GetLocation(OBJECT_SELF));

  SendMessageToPC(GetFirstPC(), BUILD_LANG_RES_NOTMORE);
}
