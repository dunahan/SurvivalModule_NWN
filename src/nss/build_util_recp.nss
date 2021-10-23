#include "x3_inc_string"
#include "build_util_wrkb"
#include "build_util_lang"

  const string BUILD_UTILS_CONTAINER = "BUILD_Container";

//Returns TRUE if oItem is stackable
int GetIsStackableItem(object oItem)
{
  object oCopy, oContainer = GetObjectByTag(BUILD_UTILS_CONTAINER);
  if (!GetIsObjectValid(oContainer))
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetStartingLocation(), FALSE, BUILD_UTILS_CONTAINER);

  oCopy = CopyItem(oItem, oContainer);
  SetItemStackSize(oCopy, 2);
  int bStack = GetItemStackSize(oCopy) == 2;

  DestroyObject(oCopy);

  return bStack;
}

string BUILD_GetObjectName(string sTagOrResRef)
{
  return GetName(GetObjectByTag(sTagOrResRef));
}

int BUILD_GetCrafterLvl(object oCrafter)
{
  return GetHitDice(oCrafter);
}

string BUILD_CreateRecipeLabel(int nRow, object oWorkbench=OBJECT_SELF)
{
  string l = "Error";
  l = Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME001, nRow);

  return l;
}

int BUILD_GetTotalNumberOfAvailableRessources(object oWorkbench, string sRessource)
{
  object oItem = GetFirstItemInInventory(oWorkbench); int b;
  while (GetIsObjectValid(oItem))
  {
    if (GetResRef(oItem) == sRessource && GetIsStackableItem(oItem) == FALSE)
      b += 1;

    else if (GetResRef(oItem) == sRessource && GetIsStackableItem(oItem) == TRUE)
      b += GetItemStackSize(oItem);

    oItem = GetNextItemInInventory(oWorkbench);
  }

  return b;
}

string BUILD_MissingRessourceColor(object oWorkbench, string sRessource, int nTotalNumber=1)
{
  if (BUILD_GetTotalNumberOfAvailableRessources(oWorkbench, sRessource) >= nTotalNumber)
    return BUILD_GetObjectName(sRessource);

  return StringToRGBString(BUILD_GetObjectName(sRessource), STRING_COLOR_RED);
}

string BUILD_BuildUpComponentText(int nRow, object oWorkbench)
{
  string t = "Error";

  t  = IntToString(BUILD_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME007, nRow))) + " / " + Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME008, nRow)+"   ";
  t += BUILD_MissingRessourceColor(oWorkbench, Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME007, nRow), StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME008, nRow)))+"\n";

  if  (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME010, nRow) != "")
  {
    t += IntToString(BUILD_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME009, nRow))) + " / " + Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME010, nRow)+"   ";
    t += BUILD_MissingRessourceColor(oWorkbench, Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME009, nRow), StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME010, nRow)))+"\n";
  }

  if  (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME012, nRow) != "")
  {
    t += IntToString(BUILD_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME011, nRow))) + " / " + Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME012, nRow)+"   ";
    t += BUILD_MissingRessourceColor(oWorkbench, Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME011, nRow), StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME012, nRow)))+"\n";
  }

  //if more components are defined, copy the last rows and modify them
  return t;
}

string BUILD_CreateRecipeText(int nRow, object oCrafter, object oWorkbench=OBJECT_SELF)
{
  string t = "Error";

  t  = "Hierzu werden folgende Dinge benötigt:\n";
  t += BUILD_BuildUpComponentText(nRow, oWorkbench);
  t += "\nDu kannst das";

  if (BUILD_GetCrafterLvl(oCrafter) >= StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME003, nRow)))
    t += " einfach ";

  else
    t += " noch nicht ";

  t += "herstellen.";

  return t;
}

int BUILD_IsRecipePossibleToBuild(object oCrafter, object oWorkbench, int nRow)
{
  int b = FALSE;
  //first check is crafter lvl equal or greater?
  if (BUILD_GetCrafterLvl(oCrafter) >= StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME003, nRow)))
    b = TRUE;
  else
    b = FALSE;

  //now check are enough materials available?
  if (BUILD_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME007, nRow)) >= StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME008, nRow)))
    b = TRUE;
  else
    b = FALSE;

  if  (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME010, nRow) != "")
  {
    if (BUILD_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME009, nRow)) >= StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME010, nRow)))
      b = TRUE;
    else
      b = FALSE;
  }

  if  (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME012, nRow) != "")
  {
    if (BUILD_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME011, nRow)) >= StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME012, nRow)))
      b = TRUE;
    else
      b = FALSE;
  }

  return b;
}

string BUILD_CollectProductData(int nRow, object oWorkbench=OBJECT_SELF)
{
  return Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME006, nRow)+"|"+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME002, nRow);
}

string BUILD_CollectComponentData(int nRow, object oWorkbench=OBJECT_SELF)
{
  string sReturn = Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME007, nRow)+"|"+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME008, nRow);    //and how many are needed for one product

  if  (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME010, nRow) != "")                   //only collect more data oly if needed
    sReturn += ","+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME009, nRow)+"|"+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME010, nRow);

  if  (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME012, nRow) != "")
    sReturn += ","+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME011, nRow)+"|"+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME012, nRow);

  return sReturn;
}

string BUILD_CollectBiProductData(int nRow, object oWorkbench=OBJECT_SELF)
{
  string sReturn = "";
  if  (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME014, nRow) != "")                   //not every recipe must have a biproduct ;-)
    sReturn = Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME013, nRow)+"|"+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME014, nRow);

  if  (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME016, nRow) != "")
    sReturn += ","+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME015, nRow)+"|"+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME016, nRow);

  if  (Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME018, nRow) != "")
    sReturn += ","+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME017, nRow)+"|"+Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME018, nRow);

  return sReturn;
}

int BUILD_CollectAttributeData(int nRow, object oWorkbench=OBJECT_SELF)
{
  int nAttrAff  = StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME019, nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME020, nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME021, nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME022, nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME023, nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), BUILD_2DA_COLNAME024, nRow));   //that sum up, if any bonus is given
  return nAttrAff;
}

int BUILD_UseComponents(object oComponent, int nComponentsToUse=1)               //nComponentsToUse only when stackable!
{
  int c = 0, bStackable = GetIsStackableItem(oComponent);
  object oCopy;

  if (!GetIsStackableItem(oComponent))
  {                                                                             //non stackable
    //oCopy = CopyItem(oComponent, GetObjectByTag("_muellfass"), TRUE);
    c++;

    DestroyObject(oComponent , 0.1);
  }

  else if (GetIsStackableItem(oComponent)
       &&  GetItemStackSize(oComponent) <= nComponentsToUse)
  {                                                                             //stackable but not enough or equal
    //oCopy = CopyItem(oComponent, GetObjectByTag("_muellfass"), TRUE);
    //SetItemStackSize(oCopy, nComponentsToUse);
    c += GetItemStackSize(oComponent);

    DestroyObject(oComponent , 0.1);
  }

  else
  {                                                                             //stackable and more then needed
    SetItemStackSize(oComponent, GetItemStackSize(oComponent)-nComponentsToUse);
    //oCopy = CopyItem(oComponent, GetObjectByTag("_muellfass"), TRUE);
    //SetItemStackSize(oCopy, nComponentsToUse);

    c += nComponentsToUse;
  }

  return c;
}

void BUILD_CreateCraftingResult(object oUser, string sProductData, object oWorkbench=OBJECT_SELF)
{
  string sItemToCreate = StringParse(sProductData, "|");                                  //like "build_itm_hlzkhl"
  int nItemToCreate = StringToInt(StringRemoveParsed(sProductData, sItemToCreate, "|"));  //like "1"
  object oCraftingResult = CreateItemOnObject(sItemToCreate, oWorkbench, nItemToCreate);
  SetIdentified(oCraftingResult, TRUE);

  SendMessageToPC(oUser, BUILD_LANG_RCP_CRAFTS1+GetName(oCraftingResult)+BUILD_LANG_RCP_CRAFTS2);
}


