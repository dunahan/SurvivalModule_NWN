#include "x3_inc_string"

//Returns TRUE if oItem is stackable
int GetIsStackableItem(object oItem)
{
  object oCopy, oContainer = GetObjectByTag("ICNR_Container");
  if (!GetIsObjectValid(oContainer))
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetStartingLocation(), FALSE, "ICNR_Container");

  oCopy = CopyItem(oItem, oContainer);
  SetItemStackSize(oCopy, 2);
  int bStack = GetItemStackSize(oCopy) == 2;

  DestroyObject(oCopy);

  return bStack;
}

string ICNR_GetObjectName(string sTagOrResRef)
{
  return GetName(GetObjectByTag(sTagOrResRef));
}

int ICNR_GetCrafterLvl(object oCrafter)
{
  return GetHitDice(oCrafter);
}

string ICNR_CreateRecipeLabel(int nRow, object oWorkbench=OBJECT_SELF)
{
  string l = "Error";
  l = Get2DAString(GetTag(oWorkbench), "Label", nRow);

  return l;
}

int ICNR_GetTotalNumberOfAvailableRessources(object oWorkbench, string sRessource)
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

string ICNR_MissingRessourceColor(object oWorkbench, string sRessource, int nTotalNumber=1)
{
  if (ICNR_GetTotalNumberOfAvailableRessources(oWorkbench, sRessource) >= nTotalNumber)
    return ICNR_GetObjectName(sRessource);

  return StringToRGBString(ICNR_GetObjectName(sRessource), STRING_COLOR_RED);
}

string ICNR_BuildUpComponentText(int nRow, object oWorkbench)
{
  string t = "Error";

  t  = IntToString(ICNR_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), "Comp1", nRow))) + " / " + Get2DAString(GetTag(oWorkbench), "AnzC1", nRow)+"   ";
  t += ICNR_MissingRessourceColor(oWorkbench, Get2DAString(GetTag(oWorkbench), "Comp1", nRow), StringToInt(Get2DAString(GetTag(oWorkbench), "AnzC1", nRow)))+"\n";

  if  (Get2DAString(GetTag(oWorkbench), "AnzC2", nRow) != "")
  {
    t += IntToString(ICNR_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), "Comp2", nRow))) + " / " + Get2DAString(GetTag(oWorkbench), "AnzC2", nRow)+"   ";
    t += ICNR_MissingRessourceColor(oWorkbench, Get2DAString(GetTag(oWorkbench), "Comp2", nRow), StringToInt(Get2DAString(GetTag(oWorkbench), "AnzC2", nRow)))+"\n";
  }

  if  (Get2DAString(GetTag(oWorkbench), "AnzC3", nRow) != "")
  {
    t += IntToString(ICNR_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), "Comp3", nRow))) + " / " + Get2DAString(GetTag(oWorkbench), "AnzC3", nRow)+"   ";
    t += ICNR_MissingRessourceColor(oWorkbench, Get2DAString(GetTag(oWorkbench), "Comp3", nRow), StringToInt(Get2DAString(GetTag(oWorkbench), "AnzC3", nRow)))+"\n";
  }

  //if more components are defined, copy the last rows and modify them
  return t;
}

string ICNR_CreateRecipeText(int nRow, object oCrafter, object oWorkbench=OBJECT_SELF)
{
  string t = "Error";

  t  = "Hierzu werden folgende Dinge benötigt:\n";
  t += ICNR_BuildUpComponentText(nRow, oWorkbench);
  t += "\nDu kannst das";

  if (ICNR_GetCrafterLvl(oCrafter) >= StringToInt(Get2DAString(GetTag(oWorkbench), "Lvl", nRow)))
    t += " einfach ";

  else
    t += " noch nicht ";

  t += "herstellen.";

  return t;
}

int ICNR_IsRecipePossibleToBuild(object oCrafter, object oWorkbench, int nRow)
{
  int b = FALSE;
  //first check is crafter lvl equal or greater?
  if (ICNR_GetCrafterLvl(oCrafter) >= StringToInt(Get2DAString(GetTag(oWorkbench), "Lvl", nRow)))
    b = TRUE;
  else
    b = FALSE;

  //now check are enough materials available?
  if (ICNR_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), "Comp1", nRow)) >= StringToInt(Get2DAString(GetTag(oWorkbench), "AnzC1", nRow)))
    b = TRUE;
  else
    b = FALSE;

  if  (Get2DAString(GetTag(oWorkbench), "AnzC2", nRow) != "")
  {
    if (ICNR_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), "Comp2", nRow)) >= StringToInt(Get2DAString(GetTag(oWorkbench), "AnzC2", nRow)))
      b = TRUE;
    else
      b = FALSE;
  }

  if  (Get2DAString(GetTag(oWorkbench), "AnzC3", nRow) != "")
  {
    if (ICNR_GetTotalNumberOfAvailableRessources(oWorkbench, Get2DAString(GetTag(oWorkbench), "Comp3", nRow)) >= StringToInt(Get2DAString(GetTag(oWorkbench), "AnzC3", nRow)))
      b = TRUE;
    else
      b = FALSE;
  }

  return b;
}

string ICNR_CollectProductData(int nRow, object oWorkbench=OBJECT_SELF)
{
  return Get2DAString(GetTag(oWorkbench), "Product", nRow)+"|"+Get2DAString(GetTag(oWorkbench), "Anz", nRow);
}

string ICNR_CollectComponentData(int nRow, object oWorkbench=OBJECT_SELF)
{
  string sReturn = Get2DAString(GetTag(oWorkbench), "Comp1", nRow)+"|"+Get2DAString(GetTag(oWorkbench), "AnzC1", nRow);    //and how many are needed for one product

  if  (Get2DAString(GetTag(oWorkbench), "AnzC2", nRow) != "")                   //only collect more data oly if needed
    sReturn += ","+Get2DAString(GetTag(oWorkbench), "Comp2", nRow)+"|"+Get2DAString(GetTag(oWorkbench), "AnzC2", nRow);

  if  (Get2DAString(GetTag(oWorkbench), "AnzC3", nRow) != "")
    sReturn += ","+Get2DAString(GetTag(oWorkbench), "Comp3", nRow)+"|"+Get2DAString(GetTag(oWorkbench), "AnzC3", nRow);

  return sReturn;
}

string ICNR_CollectBiProductData(int nRow, object oWorkbench=OBJECT_SELF)
{
  string sReturn = "";
  if  (Get2DAString(GetTag(oWorkbench), "AnzB1", nRow) != "")                   //not every recipe must have a biproduct ;-)
    sReturn = Get2DAString(GetTag(oWorkbench), "BiProd1", nRow)+"|"+Get2DAString(GetTag(oWorkbench), "AnzB1", nRow);

  if  (Get2DAString(GetTag(oWorkbench), "AnzB2", nRow) != "")
    sReturn += ","+Get2DAString(GetTag(oWorkbench), "BiProd2", nRow)+"|"+Get2DAString(GetTag(oWorkbench), "AnzB2", nRow);

  if  (Get2DAString(GetTag(oWorkbench), "AnzB3", nRow) != "")
    sReturn += ","+Get2DAString(GetTag(oWorkbench), "BiProd3", nRow)+"|"+Get2DAString(GetTag(oWorkbench), "AnzB3", nRow);

  return sReturn;
}

int ICNR_CollectAttributeData(int nRow, object oWorkbench=OBJECT_SELF)
{
  int nAttrAff  = StringToInt(Get2DAString(GetTag(oWorkbench), "Str", nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), "Dex", nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), "Con", nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), "Int", nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), "Wis", nRow));
      nAttrAff += StringToInt(Get2DAString(GetTag(oWorkbench), "Cha", nRow));   //that sum up, if any bonus is given
  return nAttrAff;
}

int ICNR_UseComponents(object oComponent, int nComponentsToUse=1)               //nComponentsToUse only when stackable!
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

void ICNR_CreateCraftingResult(object oUser, string sProductData, object oWorkbench=OBJECT_SELF)
{
  string sItemToCreate = StringParse(sProductData, "|");                                  //like "icnr_itm_hlzkohl"
  int nItemToCreate = StringToInt(StringRemoveParsed(sProductData, sItemToCreate, "|"));  //like "1"
  object oCraftingResult = CreateItemOnObject(sItemToCreate, oWorkbench, nItemToCreate);
  SetIdentified(oCraftingResult, TRUE);

  SendMessageToPC(oUser, "Du hast hier erfolgreich "+GetName(oCraftingResult)+" hergestellt.");
}


