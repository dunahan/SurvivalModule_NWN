#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
        object oPC = GetItemActivator();
        object oBuildNote = GetItemActivated();
        location lBuildSite = GetItemActivatedTargetLocation();
        object oArea = GetAreaFromLocation(lBuildSite);
        object oTargetSite = GetItemActivatedTarget();
        int s = 0, t = GetLocalInt(oArea, "o");

        if (t > 0)
        {
            while (s <= t)
            {
                DestroyObject(GetNearestObjectByTag("build_gridhelper", oPC, s), 1.0);
                s++;
            }
            return;
        }

        int w = GetAreaSize(AREA_WIDTH, oArea)*10, h = GetAreaSize(AREA_HEIGHT, oArea)*10, c, i;
        object o;
        while (i <= w)
        {
            while (c <= h)
            {
                o = CreateObject(OBJECT_TYPE_PLACEABLE, "build_gridhelper", Location(oArea, Vector(IntToFloat(c), IntToFloat(i), 0.0), 0.0));
                SetLocalInt(oArea, "o", GetLocalInt(oArea, "o") + 1);
                c = c + 5;
            }
            c = 0;
            i = i +5;
        }
    }
}


