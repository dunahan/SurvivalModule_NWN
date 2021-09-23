#include "build_util_inc"

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
    object o;
    int s = 0, t = GetLocalInt(oArea, "o");

    if (!t)                                                                     // nothing spawned yet
    {
      int w = GetAreaSize(AREA_WIDTH, oArea)*10, h = GetAreaSize(AREA_HEIGHT, oArea)*10, c, r;   //Width, Height, Column, Row
      float z; location locGridHelper;
      while (r <= w)                                                            // rows are smaller/equal to width
      {
        while (c <= h)                                                          // columns are smaller/equal to height
        {
          z = DeterminateZCoordinateOnGround(oArea, IntToFloat(c), IntToFloat(r));
          locGridHelper = Location(oArea, Vector(IntToFloat(c), IntToFloat(r), z), 0.0);

          if (IsCreatedLocationValid(locGridHelper))                            // only spawn when valid???
          {
            o = CreateObject(OBJECT_TYPE_PLACEABLE, BUILD_HELPER_PLC, locGridHelper, FALSE, GetResRef(oArea)+"_"+IntToString(GetLocalInt(oArea, "o")));
            SetLocalInt(oArea, "o", GetLocalInt(oArea, "o") + 1);               // add one to the spawned
          }

          c += BUILD_HELPER_COL;                                                // next column
        }

        c = 0;                                                                  // reset columns
        r += BUILD_HELPER_ROW;                                                  // next row
      }
    }

    else                                                                        // delete the grid
    {
      while (s <= t)                                                            // count from 0 to max created
      {
        o = GetNearestObjectByTag(GetResRef(oArea)+"_"+IntToString(s), oPC);    // look for the next gridhelper
        DestroyObject(o, 0.1);                                                  // destroy gridhelper
        s++;                                                                    // count one up
      }

      DeleteLocalInt(oArea, "o");
    }
  }
}


