#include "build_util_inc"
string script = "build_struc_oncl";

void main()
{                                                                                           d("Running: "+script);
    object oPlaceable = OBJECT_SELF;
    string sResRef = GetResRef(oPlaceable);

    location lActual = GetLocation(oPlaceable);
    SetLocalLocation(oPlaceable, "Build_Actual", lActual);

    vector vActual = GetPositionFromLocation(lActual);
    int nX = FloatToInt(vActual.x), nY = FloatToInt(vActual.y),
        nZ = FloatToInt(vActual.z), nO = FloatToInt(GetFacingFromLocation(lActual));

    object oNewStructure = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef,
                           Location(GetAreaFromLocation(lActual),
                             Vector(IntToFloat(nX), IntToFloat(nY), IntToFloat(nZ)),
                             IntToFloat(nO+90))
                           );

    DestroyObject(oPlaceable, 1.0);
}
