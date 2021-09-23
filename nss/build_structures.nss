#include "build_util_inc"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
        object oPC = GetItemActivator();
        object oStructureItem = GetItemActivated();
        location lBuildStruct = GetItemActivatedTargetLocation();
        string sResRef = GetTag(oStructureItem);
        object oTargetStructs = GetItemActivatedTarget();

        if (GetObjectType(oTargetStructs) == OBJECT_TYPE_PLACEABLE)
        {
            DestroyObject(oTargetStructs, 1.0);
            return;
        }

        vector v = GetPositionFromLocation(lBuildStruct);
        int nX = RoundFloatToInt(v.x);
        int nY = RoundFloatToInt(v.y);
        int nZ = RoundFloatToInt(v.z);
        object oStructure = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef,
                            Location(GetAreaFromLocation(lBuildStruct),
                            Vector(IntToFloat(nX), IntToFloat(nY), IntToFloat(nZ)),
                            0.0)
                            );

        SetLocalObject(oStructure, "Build_Creator", oPC);
    }
}


