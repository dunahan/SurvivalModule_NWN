#include "build_util_inc"
string script = "build_mod_onload";

void main()
{
  object oModule = GetModule();

  SetModuleSwitch(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);

  SetEventScript(oModule, EVENT_SCRIPT_MODULE_ON_ACTIVATE_ITEM, "build_mod_itmact");
  SetEventScript(oModule, EVENT_SCRIPT_MODULE_ON_CLIENT_ENTER, "build_mod_plyent");

  if (BUILD_DEBUG_MSGS)
    SetEventScript(oModule, EVENT_SCRIPT_MODULE_ON_PLAYER_CHAT, "build_mod_plycht");
}
