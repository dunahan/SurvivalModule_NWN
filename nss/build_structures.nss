#include "x2_inc_switches"
#include "x3_inc_string"
#include "x0_i0_stringlib"

int RoundFloatToInt(float f)
{
    string s = FloatToString(f,3,2);                                            // returns "  2.58" or "  2.18"
           s = StringReplace(s, " ", "");                                       // removes " "
    int r = StringToInt(GetSubString(s, FindSubString(s, ".")+1, 2));           // returns "58" or "18"
    int l = StringToInt(GetSubString(s, 0, FindSubString(s, ".")));             // returns "2" or "2"
    if (r > 50) l++;                                                            // returns "3" or "2"
    return l;
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
        object oPC = GetItemActivator();
        object oStructureItem = GetItemActivated();                             SendMessageToPC(oPC, "1 "+GetName(oStructureItem)+"|"+GetTag(oStructureItem)+"|"+GetResRef(oStructureItem));
        location lBuildStruct = GetItemActivatedTargetLocation();
        string sResRef = GetLocalString(oStructureItem, "BUILD_RES");           SendMessageToPC(oPC, "2 "+sResRef);
        if (sResRef == "")
            sResRef = GetTag(oStructureItem);
                                                                                SendMessageToPC(oPC, "3 "+sResRef);
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


