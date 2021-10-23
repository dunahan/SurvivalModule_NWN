#include "build_util_inc"

void main()
{
  //collect data for the crafting process
  object oWorkbench = OBJECT_SELF, oUser = GetPCSpeaker();
  int nRow = GetLocalInt(oWorkbench, "BUILD_RecipeChoosen");                     //this is the saved row of the choosen recipe
  string sProductData   = BUILD_CollectProductData(nRow);                        //like "build_itm_hlzkohl|1"
  string sComponentData = BUILD_CollectComponentData(nRow);                      //like "build_itm_eisnerz|1,build_itm_hlzkohl|3,build_itm_tonform|1"
  string sBiProductData = BUILD_CollectBiProductData(nRow);                      //when available, then "build_itm_eisnerz|1,build_itm_hlzkohl|3,build_itm_tonform|1"
  int nAttrAff = BUILD_CollectAttributeData(nRow);                               //does any of the attributes affect the crafting? actually a sum of integers, but yet unuseable!!!

  //now collect the experience
  int nHwXP = StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME004, nRow));
  int nChXP = StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME005, nRow));

  //frist determinate success or failure, yet allways success, due I dunno what to do...
  int bSuccess = TRUE;
  int nComponentsDone;

  if (!bSuccess)
    SendMessageToPC(oUser, BUILD_LANG_DLG_NOSUCCS);

  else
  {
    //next, if success then destroy the needed compo's
    object oComponentAvailable;
    int nDestroyed, i, nComponentsCounted = CountTokens(sComponentData, ",");
    string sComponentToUse;                                                       //=> build_itm_birkhlz|3
    string sComponentToDestroy;                                                   //=> build_itm_birkhlz
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
          nDestroyed += BUILD_UseComponents(oComponentAvailable, nComponentToDestroy);

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
    AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, BUILD_FLOAT_ANIM_WB));
    DelayCommand(BUILD_FLOAT_ANIM_WB+0.1, BUILD_CreateCraftingResult(oUser, sProductData));
  }
}


