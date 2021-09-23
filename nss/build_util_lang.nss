string BUILD_LANG_DLG_WELCOME = "Wellcome!";
string BUILD_LANG_DLG_WBNEXTP = "Next.";
string BUILD_LANG_DLG_WBBACKP = "Back.";
string BUILD_LANG_DLG_WBEXITB = "End.";
string BUILD_LANG_DLG_WBBUILD = "Build it.";
string BUILD_LANG_DLG_NOSUCCS = "Kein Erfolg gehabt...";

string BUILD_LANG_RES_DMGSUC1 = "Du hast gerade ";
string BUILD_LANG_RES_DMGSUC2 = " heraus geschlagen.";
string BUILD_LANG_RES_NOTMORE = "Hier ist nichts mehr zu holen.";
string BUILD_LANG_RES_NOTOUSE = "Damit erreichst du hier nichts.";
string BUILD_LANG_RES_NOTOOLS = "Dir fehlt das passende Werkzeug: ";
string BUILD_LANG_RCP_CRAFTS1 = "Du hast hier erfolgreich ";
string BUILD_LANG_RCP_CRAFTS2 = " hergestellt.";

string BUILD_LANG_RES_DMGMUCH = "etwas ";
string BUILD_LANG_RES_DMGMORE = "mehr ";



int BUILD_SetUpConvoDefaults()
{
  SetCustomToken(500, BUILD_LANG_DLG_WELCOME);
  SetCustomToken(511, BUILD_LANG_DLG_WBNEXTP);
  SetCustomToken(512, BUILD_LANG_DLG_WBBACKP);
  SetCustomToken(513, BUILD_LANG_DLG_WBEXITB);
  SetCustomToken(514, BUILD_LANG_DLG_WBBUILD);

  return TRUE;
}
