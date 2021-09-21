string ICNR_LANG_DLG_WELCOME = "Wellcome!";
string ICNR_LANG_DLG_WBNEXTP = "Next.";
string ICNR_LANG_DLG_WBBACKP = "Back.";
string ICNR_LANG_DLG_WBEXITB = "End.";
string ICNR_LANG_DLG_WBBUILD = "Build it.";

int ICNR_SetUpConvoDefaults()
{
  SetCustomToken(500, ICNR_LANG_DLG_WELCOME);
  SetCustomToken(511, ICNR_LANG_DLG_WBNEXTP);
  SetCustomToken(512, ICNR_LANG_DLG_WBBACKP);
  SetCustomToken(513, ICNR_LANG_DLG_WBEXITB);
  SetCustomToken(514, ICNR_LANG_DLG_WBBUILD);

  return TRUE;
}
