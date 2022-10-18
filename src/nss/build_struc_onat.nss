#include "build_util_inc"
string script = "build_struc_oncl";

void main()
{                                                                                           d("Running: "+script);
    object oPlaceable = OBJECT_SELF;
    string sResRef = GetResRef(oPlaceable);
    object oCreator = GetLocalObject(oPlaceable, "Build_Creator");
    location lActual = GetLocation(oPlaceable);                                             d("VarDump: "+GetName(oPlaceable)+"\n"+sResRef+"\n"+GetName(oCreator)+"\n"+PrintLocation(lActual)+"\n"+GetName(GetLastDamager()));
    AssignCommand(GetLastDamager(), ClearAllActions(TRUE));

    string sType = GetStringRight(sResRef, 1);
    if (sType == "i")
        sResRef = GetStringLeft(sResRef, GetStringLength(sResRef)-1)+"v";       // from resref "build_beamfull_i" to "build_beamfull_v"

    object oNewStructure = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lActual); // Create solid placeable
    DestroyObject(oPlaceable, 1.0);                                             // Destroy the asset
}
