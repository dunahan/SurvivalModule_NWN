#include "build_util_inc"

void main()
{
  int bNoUse = TRUE, nLimit = (GetMaxHitPoints()*ICNR_LIMT_OF_HP) / 100;
  object oItem; string sHowMany = "etwas ";

  if (GetLocalInt(OBJECT_SELF, "ICNR_Util") == 256 ||
      GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetLastDamager())) == 256 ||
      GetLocalString(OBJECT_SELF, "ICNR_Util") == "Plant")
    bNoUse = TRUE;

  else if (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetLastDamager())) == GetLocalInt(OBJECT_SELF, "ICNR_Util"))
    bNoUse = FALSE;

  if (GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON) >=  nLimit && bNoUse == FALSE)
  {
    oItem = CreateObject(OBJECT_TYPE_ITEM, GetTag(OBJECT_SELF), GetLocation(GetLastDamager()));

    if (GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON) >=  nLimit*2)
    {
      oItem = CreateObject(OBJECT_TYPE_ITEM, GetTag(OBJECT_SELF), GetLocation(GetLastDamager()));
      sHowMany = "mehr ";
    }

    SendMessageToPC(GetLastDamager(), "Du hast gerade "+sHowMany+GetName(oItem)+" heraus geschlagen.");
  }

  else if (GetCurrentHitPoints() <= nLimit && bNoUse == FALSE)
  {
    SetPlotFlag(OBJECT_SELF, TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(9999), OBJECT_SELF);
    AssignCommand(GetLastDamager(), ClearAllActions(TRUE));
    SendMessageToPC(GetLastDamager(), "Hier ist nichts mehr zu holen.");

    DelayCommand(ICNR_WAIT_REUSE, SetPlotFlag(OBJECT_SELF, FALSE));
  }

  else if (bNoUse == TRUE)
  {
    SetPlotFlag(OBJECT_SELF, TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(9999), OBJECT_SELF);
    AssignCommand(GetLastDamager(), ClearAllActions(TRUE));
    SendMessageToPC(GetLastDamager(), "Damit erreichst du hier nichts.");

    DelayCommand(ICNR_WAIT_REUSE, SetPlotFlag(OBJECT_SELF, FALSE));
  }
}
