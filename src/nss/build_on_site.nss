#include "build_util_inc"
string script = "build_on_site"

void main()
{
  int nEvent = GetUserDefinedItemEventNumber();
  if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
  {
    object oPC = GetItemActivator();
    object oBuildNote = GetItemActivated();
    location lBuildSite = GetItemActivatedTargetLocation();
    object oArea = GetAreaFromLocation(lBuildSite);
    object oTargetSite = GetItemActivatedTarget();                              d(GetName(oPC)+"\n"+GetName(oBuildNote)+"=>"+GetResRef(oBuildNote)+"\n"+PrintLocation(lBuildSite)+"\n"+GetName(oArea)+"\n"+GetName(oTargetSite));
    object o;
    int s = 0, t = GetLocalInt(oArea, "o");

    if (!t)                                                                     // nothing spawned yet
    {                                                                                       d("Script run? "+IntToString(t));
      int w = GetAreaSize(AREA_WIDTH, oArea)*10, h = GetAreaSize(AREA_HEIGHT, oArea)*10, c, r;   //Width, Height, Column, Row
                                                                                            d("AreaSize: "+IntToString(w)+"/"+IntToString(h));
      float z; location locGridHelper;
      while (r <= w)                                                            // rows are smaller/equal to width
      {                                                                                     d("Rows/Width: "+IntToString(r)+"/"+IntToString(w));
        while (c <= h)                                                          // columns are smaller/equal to height
        {                                                                                   d("Column/Height: "+IntToString(c)+"/"+IntToString(h));
          z = DeterminateZCoordinateOnGround(oArea, IntToFloat(c), IntToFloat(r));          d("Height on tile: "+FloatToString(z));
          locGridHelper = Location(oArea, Vector(IntToFloat(c), IntToFloat(r), z), 0.0);    d("Location to spawn: "+PrintLocation(locGridHelper));

          if (IsCreatedLocationValid(locGridHelper))                            // only spawn when valid???
          {                                                                                 d("Loc valid? "+IntToString(IsCreatedLocationValid(locGridHelper)));
            o = CreateObject(OBJECT_TYPE_PLACEABLE, BUILD_HELPER_PLC, locGridHelper, FALSE, GetResRef(oArea)+"_"+IntToString(GetLocalInt(oArea, "o")));
            SetLocalInt(oArea, "o", GetLocalInt(oArea, "o") + 1);               // add one to the spawned
          }                                                                                 d(GetName(o)+"/"+IntToString(GetLocalInt(oArea, "o")));

          c += BUILD_HELPER_COL;                                                // next column
        }                                                                                   d("#Columns: "+IntToString(c));

        c = 0;                                                                  // reset columns
        r += BUILD_HELPER_ROW;                                                  // next row
      }                                                                                     d("#Rows: "+IntToString(r));
    }

    else                                                                        // delete the grid
    {                                                                                       d("Deletion follows...");
      while (s <= t)                                                            // count from 0 to max created
      {                                                                                     d(IntToString(s)+"/"+IntToString(GetLocalInt(oArea, "o")));
        o = GetNearestObjectByTag(GetResRef(oArea)+"_"+IntToString(s), oPC);    // look for the next gridhelper
        DestroyObject(o, 0.1);                                                  // destroy gridhelper
        s++;                                                                    // count one up
      }

      DeleteLocalInt(oArea, "o");
    }
  }
}


