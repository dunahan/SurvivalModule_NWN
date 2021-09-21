#include "x2_inc_switches"

void d(string m, object o=OBJECT_INVALID)
{
  if (o == OBJECT_INVALID)  o = GetFirstPC();
  SendMessageToPC(o, m);
}

int col = 5;
int row = 5;

string lts(location l)
{
  vector vLTS = GetPositionFromLocation(l);
  return GetResRef(GetAreaFromLocation(l))+"|"+
         GetTag(GetAreaFromLocation(l))+"|"+
         FloatToString(vLTS.x,3,3)+"|"+
         FloatToString(vLTS.y,3,3)+"|"+
         FloatToString(vLTS.z,3,3);
         FloatToString(GetFacingFromLocation(l));
}

float DeterminateZCoordinateOnGround(object oArea, float x=0.0f, float y=0.0f)
{
  object oCreature = CreateObject(OBJECT_TYPE_CREATURE, "NW_CHICKEN", Location(oArea, Vector(x, y), 0.0f));
  vector vActual = GetPositionFromLocation(GetLocation(oCreature));
  DestroyObject(oCreature);

  return vActual.z;
}

int IsCreatedLocationValid(location locCreated)
{
  object oCreature = CreateObject(OBJECT_TYPE_CREATURE, "NW_CHICKEN", locCreated);
  vector vCreature = GetPositionFromLocation(GetLocation(oCreature));
  vector vCreated = GetPositionFromLocation(locCreated);
  DestroyObject(oCreature);

  d("orgi> "+lts(locCreated));
  d("test> "+lts(GetLocation(oCreature)));

  if (FloatToString(vCreated.x,3,3) == FloatToString(vCreature.x,3,3) &&
      FloatToString(vCreated.y,3,3) == FloatToString(vCreature.y,3,3) &&
      FloatToString(vCreated.z,3,3) == FloatToString(vCreature.z,3,3)    )
    return TRUE;

  else
    return FALSE;

  return FALSE;
}

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
//        d("res> "+lts(locGridHelper), oPC);                                   // debug msg
          d(IntToString(IsCreatedLocationValid(locGridHelper))+"\n", oPC);      // debug msg
        //if (IsCreatedLocationValid(locGridHelper))                            // only spawn when valid???
          {
            o = CreateObject(OBJECT_TYPE_PLACEABLE, "build_gridhelper", locGridHelper, FALSE, GetResRef(oArea)+"_"+IntToString(GetLocalInt(oArea, "o")));
            d("obj> "+GetTag(o)+lts(locGridHelper), oPC);                       // debug msg
            SetLocalInt(oArea, "o", GetLocalInt(oArea, "o") + 1);               // add one to the spawned
          }

          c += col;                                                             // next column
        }

        c = 0;                                                                  // reset columns
        r += row;                                                               // next row
      }
    }

    else                                                                        // delete the grid
    {
      while (s <= t)                                                            // count from 0 to max created
      {
        o = GetNearestObjectByTag(GetResRef(oArea)+"_"+IntToString(s), oPC);    // look for the next gridhelper
//          d("del> "+GetTag(o)+lts(GetLocation(o)), oPC);                      // debug msg
        DestroyObject(o, 0.1);                                                  // destroy gridhelper
        s++;                                                                    // count one up
      }

      DeleteLocalInt(oArea, "o");
    }

    d("crd> "+IntToString(GetLocalInt(oArea, "o")), oPC);
  }
}


