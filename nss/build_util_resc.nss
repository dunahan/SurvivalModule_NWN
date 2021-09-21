const float ICNR_FLOAT_ANIM_RES = 6.0;

int ICNR_SaveRessource(object oRessource=OBJECT_SELF)
{
  object oSpawnPoint = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", GetLocation(oRessource));
  SetLocalString(oSpawnPoint, "ICNR_SpawnData", GetName(oRessource)+"|"+GetResRef(oRessource)+"|"+GetTag(oRessource));
  SetLocalInt(oSpawnPoint, "ICNR_Util", GetLocalInt(oRessource, "ICNR_Util"));
  SetLocalString(oSpawnPoint, "ICNR_Util", GetLocalString(oRessource, "ICNR_Util"));

  return GetIsObjectValid(oSpawnPoint);
}

void ICNR_CreateLandRessource(object oUser, object oSource)
{
  object oItem = CreateObject(OBJECT_TYPE_ITEM, GetTag(oSource), GetLocation(oUser));
  SendMessageToPC(oUser, "Hier hast Du "+GetName(oItem)+" bekommen.");
}

void ICNR_WorkingAnimOnLandRessources(object oUser, object oSource=OBJECT_SELF)
{
  AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, ICNR_FLOAT_ANIM_RES));
  DelayCommand(ICNR_FLOAT_ANIM_RES+0.1, ICNR_CreateLandRessource(oUser, oSource));
}

string ICNR_MissingCraftingTool(object oSource=OBJECT_SELF)
{
  if (GetTag(oSource) == "icnr_itm_beusand" || GetTag(oSource) == "icnr_itm_tonklum")
    return "Schaufel";

  if (GetTag(oSource) == "icnr_itm_birkhlz")
    return "Beil oder Axt";

  if (GetTag(oSource) == "icnr_itm_eisnerz")
    return "Hammer";

  return "Unbekannt";
}
