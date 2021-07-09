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

    object oSavePoint = GetObjectByTag("build_savedb");
    if (!GetIsObjectValid(oSavePoint))                                          // Load Database
        oSavePoint = RetrieveCampaignObject("Build_DB", GetResRef(GetArea(oPlaceable)), lActual);

    if (!GetIsObjectValid(oSavePoint))                                          // Database empty
        oSavePoint = CreateObject(OBJECT_TYPE_CREATURE, "build_savedb", lActual);

    object oNewStructure = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef,
                           Location(GetAreaFromLocation(lActual),
                             Vector(IntToFloat(nX), IntToFloat(nY), IntToFloat(nZ)),
                             IntToFloat(nO))
                           );                                                   // Create solid placeable

    if (GetIsObjectValid(oSavePoint))                                           // Save Data to placeable
    {
        i = GetLocalInt (oSavePoint,    "Build_Nmb_Struct");                                                SendMessageToPC(GetFirstPC(), IntToString(i));
        SetLocalLocation(oNewStructure, "Build_Loc_"+IntToString(i), GetLocation(oNewStructure));           SendMessageToPC(GetFirstPC(), LocationToString(GetLocalLocation(oNewStructure, "Build_Loc_"+IntToString(i))));
        SetLocalObject  (oSavePoint,    "Build_Str_"+IntToString(i), oNewStructure);                        SendMessageToPC(GetFirstPC(), GetName(GetLocalObject(oSavePoint, "Build_Str_"+IntToString(i))));
        SetLocalInt     (oSavePoint,    "Build_Nmb_Struct", GetLocalInt(oSavePoint, "Build_Nmb_Struct")+1); SendMessageToPC(GetFirstPC(), IntToString(GetLocalInt(oSavePoint, "Build_Nmb_Struct")));
    }

    DestroyObject(oPlaceable, 1.0);                                             // Destroy the asset
}
