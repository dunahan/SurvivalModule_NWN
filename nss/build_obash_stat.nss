#include "x0_i0_position"

void main()
{
    object oPlaceable = OBJECT_SELF;
    string sResRef = GetLocalString(oPlaceable, "BUILD_RES");

    location lActual = GetLocation(oPlaceable);
    vector vActual = GetPositionFromLocation(lActual);
    int i, nX = FloatToInt(vActual.x), nY = FloatToInt(vActual.y),
           nZ = FloatToInt(vActual.z), nO = FloatToInt(GetFacingFromLocation(lActual));

    object oNewStructure = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lActual); // Create solid placeable

    DestroyObject(oPlaceable, 1.0);                                             // Destroy the asset
    AssignCommand(GetLastAttacker(), ClearAllActions(TRUE));
}
