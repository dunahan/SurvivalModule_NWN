const float BUILD_FLOAT_ANIM_RES = 6.0;
const string BUILD_RESTAG_SAND = "build_itm_bsand";
const string BUILD_RESTAG_CLAY = "build_itm_tonkl";
const string BUILD_RESTAG_WOD1 = "build_itm_bkhlz";
const string BUILD_RESTAG_ORE1 = "build_itm_esnrz";

const string BUILD_TOOL_SANDC  = "Schaufel";
const string BUILD_TOOL_WOODS  = "Beil oder Axt";
const string BUILD_TOOL_ORES   = "Hammer";
const string BUILD_UNKNOWN     = "Unbekannt";

const string BUILD_MSGCRE_RES1 = "Hier hast Du ";
const string BUILD_MSGCRE_RES2 = " bekommen.";

int BUILD_SaveRessource(object oRessource=OBJECT_SELF)
{
  object oSpawnPoint = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", GetLocation(oRessource));
  SetLocalString(oSpawnPoint, "BUILD_SpawnData", GetName(oRessource)+"|"+GetResRef(oRessource)+"|"+GetTag(oRessource));
  SetLocalInt(oSpawnPoint, "BUILD_Util", GetLocalInt(oRessource, "BUILD_Util"));
  SetLocalString(oSpawnPoint, "BUILD_Util", GetLocalString(oRessource, "BUILD_Util"));

  return GetIsObjectValid(oSpawnPoint);
}

void BUILD_CreateLandRessource(object oUser, object oSource)
{
  object oItem = CreateObject(OBJECT_TYPE_ITEM, GetTag(oSource), GetLocation(oUser));
  SendMessageToPC(oUser, BUILD_MSGCRE_RES1+GetName(oItem)+BUILD_MSGCRE_RES2);
}

void BUILD_WorkingAnimOnLandRessources(object oUser, object oSource=OBJECT_SELF)
{
  AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, BUILD_FLOAT_ANIM_RES));
  DelayCommand(BUILD_FLOAT_ANIM_RES+0.1, BUILD_CreateLandRessource(oUser, oSource));
}



string BUILD_MissingCraftingTool(object oSource=OBJECT_SELF)
{
  if (GetTag(oSource) == BUILD_RESTAG_SAND  || GetTag(oSource) == BUILD_RESTAG_CLAY  )
    return BUILD_TOOL_SANDC;

  if (GetTag(oSource) == BUILD_RESTAG_WOD1/*|| GetTag(oSource) == BUILD_RESTAG_WOD2*/)
    return BUILD_TOOL_WOODS;

  if (GetTag(oSource) == BUILD_RESTAG_ORE1/*|| GetTag(oSource) == BUILD_RESTAG_ORE1*/)
    return BUILD_TOOL_ORES;

  return BUILD_UNKNOWN;
}
