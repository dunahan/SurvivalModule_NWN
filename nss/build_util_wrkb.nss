const int BUILD_MAXRECI_PG = 5;      // 5 entries per page is minimum! 10 maximum!

  const string BUILD_2DA_COLNAME001 = "Label"; // following the 2da column names for workbenches
  const string BUILD_2DA_COLNAME002 = "Anz";
  const string BUILD_2DA_COLNAME003 = "Lvl";
  const string BUILD_2DA_COLNAME004 = "HwXp";
  const string BUILD_2DA_COLNAME005 = "ChXP";
  const string BUILD_2DA_COLNAME006 = "Product";
  const string BUILD_2DA_COLNAME007 = "Comp1";
  const string BUILD_2DA_COLNAME008 = "AnzC1";
  const string BUILD_2DA_COLNAME009 = "Comp2";
  const string BUILD_2DA_COLNAME010 = "AnzC2";
  const string BUILD_2DA_COLNAME011 = "Comp3";
  const string BUILD_2DA_COLNAME012 = "AnzC3";
  const string BUILD_2DA_COLNAME013 = "BiProd1";
  const string BUILD_2DA_COLNAME014 = "AnzB1";
  const string BUILD_2DA_COLNAME015 = "BiProd2";
  const string BUILD_2DA_COLNAME016 = "AnzB2";
  const string BUILD_2DA_COLNAME017 = "BiProd2";
  const string BUILD_2DA_COLNAME018 = "AnzB2";
  const string BUILD_2DA_COLNAME019 = "Str";
  const string BUILD_2DA_COLNAME020 = "Dex";
  const string BUILD_2DA_COLNAME021 = "Con";
  const string BUILD_2DA_COLNAME022 = "Int";
  const string BUILD_2DA_COLNAME023 = "Wis";
  const string BUILD_2DA_COLNAME024 = "Cha";

int BUILD_CountPages(int nReciepes)
{
  float fResult = IntToFloat(nReciepes) / IntToFloat(BUILD_MAXRECI_PG);          // 1.40 if 5 reciepes per page and 7 exist
  string sResult = FloatToString(fResult,3,1);                                  // convert it to string like <  1.4>
  int nAfterDecimalPoint = StringToInt(GetStringRight(sResult, FindSubString(sResult, ".")));

  if (nAfterDecimalPoint == 0)
    return FloatToInt(fResult);
  else
    return FloatToInt(fResult+1);
}

int BUILD_SetPages(object oCaller=OBJECT_SELF)
{
  int nPages = BUILD_CountPages(StringToInt(Get2DAString(GetTag(OBJECT_SELF), BUILD_2DA_COLNAME002, 0)));
  SetLocalInt(oCaller, "BUILD_Pages", nPages);
  return nPages;
}

int BUILD_CalcReciepeToken(int nPage)
{
  if (nPage == 1)
    return 0;
  else
    return (nPage-1) * BUILD_MAXRECI_PG;
}

