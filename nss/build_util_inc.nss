#include "build_util_recp"
#include "build_util_wrkb"
#include "build_util_resc"
#include "build_util_lang"

//const int   ICNR_MAXRECI_PG = 5;      // found in icnr_util_workb
//const float ICNR_FLOAT_ANIM_RES = 6.0;// found in icnr_util_res
  const float ICNR_WAIT_REUSE = 6.0;
  const int   ICNR_LIMT_OF_HP = 20;     // percentage
  const float ICNR_FLOAT_ANIM_WB = 6.0;


int CountTokens(string sTokenString, string sDemiliter)                         //icnr_itm_eisnerz,1|icnr_itm_hlzkohl,3|icnr_itm_tonform,1
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

void d(string s)
{
  SendMessageToPC(GetFirstPC(), s);
}

//_muellfass
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
