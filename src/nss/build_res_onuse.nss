#include "build_util_inc"
string script = "build_res_onuse";

void main()
{
  object oUser = GetLastUsedBy(), oSource = OBJECT_SELF;

  if (GetLocalString(oSource, "BUILD_Util") == "Plant")
    BUILD_WorkingAnimOnLandRessources(oUser);

  else if (!GetIsObjectValid(GetItemPossessedBy(oUser, GetLocalString(oSource, "BUILD_Util"))))
    SendMessageToPC(oUser, BUILD_LANG_RES_NOTOOLS+BUILD_MissingCraftingTool());

  else
    BUILD_WorkingAnimOnLandRessources(oUser);
}

