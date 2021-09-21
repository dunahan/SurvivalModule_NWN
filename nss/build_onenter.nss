#include "x3_inc_horse"
#include "x2_inc_itemprop"

int div(object o)
{
    object i = GetFirstItemInInventory(o); int b = 0;
    while (GetIsObjectValid(i))
    {
        DestroyObject(i);
        i = GetNextItemInInventory(o);
        b++;
    }

    return b;
}

void main()
{
    object oPC = GetEnteringObject();
    object oItem1, oItem2, oItem3, oItem4, oItem5, oItem6;
    int nInv = div(oPC);

    {
        oItem1 = CreateItemOnObject("build_structures", oPC, 1, "build_beamfull_invis");
        SetName(oItem1, "Beam");

        oItem2 = CreateItemOnObject("build_structures", oPC, 1, "build_postfull_invis");
        SetName(oItem2, "Post, Full");

        oItem3 = CreateItemOnObject("build_structures", oPC, 1, "build_posthalf_invis");
        SetName(oItem3, "Post, Half");

        oItem4 = CreateItemOnObject("build_structures", oPC, 1, "build_wallfull_invis");
        SetName(oItem4, "Wall, Full");

        oItem5 = CreateItemOnObject("build_structures", oPC, 1, "build_wallhalf_invis");
        SetName(oItem5, "Wall, Half");

        oItem6 = CreateItemOnObject("build_on_site", oPC);
    }

    itemproperty neat = ItemPropertyBonusFeat(IP_CONST_FEAT_WEAPON_PROF_MARTIAL);
    IPSafeAddItemProperty(SKIN_SupportGetSkin(oPC), neat, 0.0f);

    ExecuteScript("x3_mod_def_enter", oPC);
}
