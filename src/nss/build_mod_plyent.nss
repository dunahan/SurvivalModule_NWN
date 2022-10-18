#include "x3_inc_horse"
#include "x2_inc_itemprop"
string script = "build_mod_plyent";

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
    object a,b,c,d,e,f,g,h,i,j,k;
    int nInv = div(oPC);

    {
        a = CreateItemOnObject("build_structures", oPC, 1, "build_beamfull_invis");
        SetName(a, "Beam");

        b = CreateItemOnObject("build_structures", oPC, 1, "build_postfull_invis");
        SetName(b, "Post, Full");

        c = CreateItemOnObject("build_structures", oPC, 1, "build_posthalf_invis");
        SetName(c, "Post, Half");

        d = CreateItemOnObject("build_structures", oPC, 1, "build_wallfull_invis");
        SetName(d, "Wall, Full");

        e = CreateItemOnObject("build_structures", oPC, 1, "build_wallhalf_invis");
        SetName(e, "Wall, Half");

        f = CreateItemOnObject("build_on_site", oPC);
        g = CreateItemOnObject("build_struc_hmr", oPC);

    }

    itemproperty neat = ItemPropertyBonusFeat(IP_CONST_FEAT_WEAPON_PROF_MARTIAL);
    IPSafeAddItemProperty(SKIN_SupportGetSkin(oPC), neat, 0.0f);

    ExecuteScript("x3_mod_def_enter", oPC);
}
