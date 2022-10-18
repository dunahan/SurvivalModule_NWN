
string script = "build_mod_plycht";

void main()
{
  string sChatMsg = GetPCChatMessage();

  if (sChatMsg == "rlg")
    StartNewModule("SurvMod_NWN");
}
