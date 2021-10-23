#include "build_util_inc"

void main()
{
  int bNoUse = TRUE, nLimit = (GetMaxHitPoints()*BUILD_LIMT_OF_HP) / 100;
  object oItem; string sHowMany = BUILD_LANG_RES_DMGMUCH;

  if (GetLocalInt(OBJECT_SELF, "BUILD_Util") == 256 ||
      GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetLastDamager())) == 256 ||
      GetLocalString(OBJECT_SELF, "BUILD_Util") == "Plant")
    bNoUse = TRUE;

  else if (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetLastDamager())) == GetLocalInt(OBJECT_SELF, "BUILD_Util"))
    bNoUse = FALSE;

  if (GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON) >=  nLimit && bNoUse == FALSE)
  {
    oItem = CreateObject(OBJECT_TYPE_ITEM, GetTag(OBJECT_SELF), GetLocation(GetLastDamager()));

    if (GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON) >=  nLimit*2)
    {
      oItem = CreateObject(OBJECT_TYPE_ITEM, GetTag(OBJECT_SELF), GetLocation(GetLastDamager()));
      sHowMany = BUILD_LANG_RES_DMGMORE;
    }

    SendMessageToPC(GetLastDamager(), BUILD_LANG_RES_DMGSUC1+sHowMany+GetName(oItem)+BUILD_LANG_RES_DMGSUC2);
  }

  else if (GetCurrentHitPoints() <= nLimit && bNoUse == FALSE)
  {
    SetPlotFlag(OBJECT_SELF, TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(9999), OBJECT_SELF);
    AssignCommand(GetLastDamager(), ClearAllActions(TRUE));
    SendMessageToPC(GetLastDamager(), BUILD_LANG_RES_NOTMORE);

    DelayCommand(BUILD_WAIT_REUSE, SetPlotFlag(OBJECT_SELF, FALSE));
  }

  else if (bNoUse == TRUE)
  {
    SetPlotFlag(OBJECT_SELF, TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(9999), OBJECT_SELF);
    AssignCommand(GetLastDamager(), ClearAllActions(TRUE));
    SendMessageToPC(GetLastDamager(), BUILD_LANG_RES_NOTOUSE);

    DelayCommand(BUILD_WAIT_REUSE, SetPlotFlag(OBJECT_SELF, FALSE));
  }
}
