const int ICNR_MAXRECI_PG = 5;      // 5 entries per page is minimum! 10 maximum!

int ICNR_CountPages(int nReciepes)
{
  float fResult = IntToFloat(nReciepes) / IntToFloat(ICNR_MAXRECI_PG);          // 1.40 if 5 reciepes per page and 7 exist
  string sResult = FloatToString(fResult,3,1);                                  // convert it to string like <  1.4>
  int nAfterDecimalPoint = StringToInt(GetStringRight(sResult, FindSubString(sResult, ".")));

  if (nAfterDecimalPoint == 0)
    return FloatToInt(fResult);
  else
    return FloatToInt(fResult+1);
}

int ICNR_SetPages(object oCaller=OBJECT_SELF)
{
  int nPages = ICNR_CountPages(StringToInt(Get2DAString(GetTag(OBJECT_SELF), "Anz", 0)));
  SetLocalInt(oCaller, "ICNR_Pages", nPages);
  return nPages;
}

int ICNR_CalcReciepeToken(int nPage)
{
  if (nPage == 1)
    return 0;
  else
    return (nPage-1) * ICNR_MAXRECI_PG;
}

