#include "build_util_recp"
#include "build_util_wrkb"
#include "build_util_resc"
#include "build_util_lang"

#include "x2_inc_switches"
#include "x0_i0_stringlib"

  const int    BUILD_HELPER_COL = 5;
  const int    BUILD_HELPER_ROW = 5;
  const int    BUILD_DEBUG_MSGS = FALSE;
  const string BUILD_HELPER_PLC = "build_gridhelper";
  const string BUILD_HELPER_CHK = "NW_CHICKEN";

//const int    BUILD_MAXRECI_PG = 5;      // found in build_util_workb
//const float  BUILD_FLOAT_ANIM_RES = 6.0;// found in build_util_res
  const float  BUILD_WAIT_REUSE = 6.0;
  const int    BUILD_LIMT_OF_HP = 20;     // percentage
  const float  BUILD_FLOAT_ANIM_WB = 6.0;



void d(string m="", object o=OBJECT_INVALID)
{
  if (!BUILD_DEBUG_MSGS)   return;
  if (m == "")  m = "Message missing!";
  if (o == OBJECT_INVALID)  o = GetFirstPC();
  SendMessageToPC(o, m);
}



int CountTokens(string sTokenString, string sDemiliter)                         //build_itm_eisnerz,1|build_itm_hlzkohl,3|build_itm_tonform,1
{                                                                               //56 > 18
  int c = 0, pos = 0;
  while(pos != -1)
  {
    c++;
    pos = FindSubString(sTokenString, sDemiliter);

    if (pos == -1)  break;

    sTokenString = GetStringRight(sTokenString, GetStringLength(sTokenString) - (pos+1)); // cut off leading token+delimiter
  }

  return c;
}

// Moving to trashcan
void ReduceStackedItems(object oTarget, string sItem, int nNumItems)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
            ActionTakeItem(oItem, oTarget);
            nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return;
}

int RoundFloatToInt(float f)
{
    string s = FloatToString(f,3,2);                                            // returns "  2.58" or "  2.18"
           s = StringReplace(s, " ", "");                                       // removes " "
    int r = StringToInt(GetSubString(s, FindSubString(s, ".")+1, 2));           // returns "58" or "18"
    int l = StringToInt(GetSubString(s, 0, FindSubString(s, ".")));             // returns "2" and "2"
    if (r > 50) l++;                                                            // returns "3" or "2"
    return l;
}

string RoundFloatToString(float f)
{
    string s = FloatToString(f,3,2);                                            // returns "  2.58" or "  2.18"
           s = StringReplace(s, " ", "");                                       // removes " "
    int r = StringToInt(GetSubString(s, FindSubString(s, ".")+1, 2));           // returns "58" or "18"
    int l = StringToInt(GetSubString(s, 0, FindSubString(s, ".")));             // returns "2" and "2"
    if (r > 50) l++;                                                            // returns "3" or "2"
    return IntToString(l);
}

string PrintLocation(location l)
{
  vector vLTS = GetPositionFromLocation(l);
  return GetResRef(GetAreaFromLocation(l))+"|"+
         GetTag(GetAreaFromLocation(l))+"|"+
         FloatToString(vLTS.x,3,3)+"|"+
         FloatToString(vLTS.y,3,3)+"|"+
         FloatToString(vLTS.z,3,3);
         FloatToString(GetFacingFromLocation(l));
}

float DeterminateZCoordinateOnGround(object oArea, float x=0.0f, float y=0.0f)
{
  object oCreature = CreateObject(OBJECT_TYPE_CREATURE, BUILD_HELPER_CHK, Location(oArea, Vector(x, y), 0.0f));
  vector vActual = GetPositionFromLocation(GetLocation(oCreature));
  DestroyObject(oCreature);

  return vActual.z;
}

int IsCreatedLocationValid(location locCreated)
{
  object oCreature = CreateObject(OBJECT_TYPE_CREATURE, BUILD_HELPER_CHK, locCreated);
  vector vCreature = GetPositionFromLocation(GetLocation(oCreature));
  vector vCreated = GetPositionFromLocation(locCreated);
  DestroyObject(oCreature);

  if (RoundFloatToString(vCreated.x) == RoundFloatToString(vCreature.x) &&
      RoundFloatToString(vCreated.y) == RoundFloatToString(vCreature.y) &&
      RoundFloatToString(vCreated.z) == RoundFloatToString(vCreature.z)    )
    return TRUE;

  else
    return FALSE;

  return FALSE;
}
