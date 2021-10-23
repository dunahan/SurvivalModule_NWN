#include "x0_i0_position"

void main()
{
    object oPlaceable = OBJECT_SELF;
    string sResRef = GetLocalString(oPlaceable, "BUILD_RES");
    object oCreator = GetLocalObject(oPlaceable, "Build_Creator");

    location lActual = GetLocation(oPlaceable);
    vector vActual = GetPositionFromLocation(lActual);
    int i, nX = FloatToInt(vActual.x), nY = FloatToInt(vActual.y),
           nZ = FloatToInt(vActual.z), nO = FloatToInt(GetFacingFromLocation(lActual));

    AssignCommand(GetLastDamager(), ClearAllActions(TRUE));

    object oNewStructure = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lActual
/*                         Location(GetAreaFromLocation(lActual),
                           Vector(IntToFloat(nX), IntToFloat(nY), IntToFloat(nZ)),
                             IntToFloat(nO))*/
                           );                                                   // Create solid placeable

    DestroyObject(oPlaceable, 1.0);                                             // Destroy the asset
}
