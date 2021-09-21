#include "build_util_inc"

void main()
{
  //collect data for the crafting process
  object oWorkbench = OBJECT_SELF, oUser = GetPCSpeaker();
  int nRow = GetLocalInt(oWorkbench, "ICNR_RecipeChoosen");                     //this is the saved row of the choosen recipe
  string sProductData   = ICNR_CollectProductData(nRow);                        //like "icnr_itm_hlzkohl|1"
  string sComponentData = ICNR_CollectComponentData(nRow);                      //like "icnr_itm_eisnerz|1,icnr_itm_hlzkohl|3,icnr_itm_tonform|1"
  string sBiProductData = ICNR_CollectBiProductData(nRow);                      //when available, then "icnr_itm_eisnerz|1,icnr_itm_hlzkohl|3,icnr_itm_tonform|1"
  int nAttrAff = ICNR_CollectAttributeData(nRow);                               //does any of the attributes affect the crafting? actually a sum of integers, but yet unuseable!!!

  //now collect the experience
  int nHwXP = StringToInt(Get2DAString(GetTag(oWorkbench), "HwXP", nRow));
  int nChXP = StringToInt(Get2DAString(GetTag(oWorkbench), "ChXP", nRow));

  //frist determinate success or failure, yet allways success, due I dunno what to do...
  int bSuccess = TRUE;
  int nComponentsDone;

  if (!bSuccess)
    SendMessageToPC(oUser, "Kein Erfolg gehabt...");

  else
  {
    //next, if success then destroy the needed compo's
    object oComponentAvailable;
    int nDestroyed, i, nComponentsCounted = CountTokens(sComponentData, ",");
    string sComponentToUse;                                                       //=> icnr_itm_birkhlz|3
    string sComponentToDestroy;                                                   //=> icnr_itm_birkhlz
    int    nComponentToDestroy;                                                   //=> 3

    for (i = 1; i <= nComponentsCounted; i++)                                     //check all components
    {
      oComponentAvailable = GetFirstItemInInventory();
      nDestroyed = 0;
      sComponentToUse = StringParse(sComponentData, ",");
      nComponentToDestroy = StringToInt(StringParse(sComponentToUse, "|", TRUE));
      sComponentToDestroy = StringParse(sComponentToUse, "|");

      while (GetIsObjectValid(oComponentAvailable))
      {
        if (GetResRef(oComponentAvailable) == sComponentToDestroy                 //place here the component searced for
        &&  nDestroyed < nComponentToDestroy)                                     //there aren't enough destroyed
          nDestroyed += ICNR_UseComponents(oComponentAvailable, nComponentToDestroy);

        if (GetResRef(oComponentAvailable) == sComponentToDestroy                 //place here the component searced for
        && nDestroyed >= nComponentToDestroy)
          sComponentData = StringRemoveParsed(sComponentData, sComponentToUse, ",");

        oComponentAvailable = GetNextItemInInventory();
      }
    }

    nComponentsDone = TRUE;
  }

  //handling of biproducts ???

  if (nComponentsDone/*&&  nBiproductsDone*/)
  {
    AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, ICNR_FLOAT_ANIM_WB));
    DelayCommand(ICNR_FLOAT_ANIM_WB+0.1, ICNR_CreateCraftingResult(oUser, sProductData));
  }
}


