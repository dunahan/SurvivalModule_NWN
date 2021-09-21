#include "build_util_inc"

void main()
{
  object oUser = GetLastUsedBy(), oSource = OBJECT_SELF;

  if (GetLocalString(oSource, "ICNR_Util") == "Plant")
    ICNR_WorkingAnimOnLandRessources(oUser);

  else if (!GetIsObjectValid(GetItemPossessedBy(oUser, GetLocalString(oSource, "ICNR_Util"))))
    SendMessageToPC(oUser, "Dir fehlt das passende Werkzeug: "+ICNR_MissingCraftingTool());

  else
    ICNR_WorkingAnimOnLandRessources(oUser);
}

