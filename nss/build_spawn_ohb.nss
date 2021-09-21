#include "build_util_inc"

void main()
{
  object oSpawnPoint = GetNearestObject(OBJECT_TYPE_WAYPOINT);
  string sSpawnData = GetLocalString(oSpawnPoint, "ICNR_SpawnData");
  string sName   = StringParse(sSpawnData, "|");
  string sTemp   = StringRemoveParsed(sSpawnData, sName, "|");
  string sResRef = StringParse(sTemp, "|");
         sTemp   = StringRemoveParsed(sTemp, sResRef, "|");
  string sTag    = StringParse(sTemp, "|");

  object oSpawned = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, GetLocation(OBJECT_SELF), FALSE, sTag);
  SetLocalInt(oSpawned, "ICNR_Util", GetLocalInt(oSpawnPoint, "ICNR_Util"));
  SetName(oSpawned, sName);
  SetPlotFlag(oSpawned, TRUE);

  DestroyObject(oSpawnPoint, 3.0);
  DestroyObject(OBJECT_SELF, 2.0);
}
