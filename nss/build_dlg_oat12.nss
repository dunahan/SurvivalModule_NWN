void main()
{
  if (GetLocalInt(OBJECT_SELF, "ICNR_ActPage") < GetLocalInt(OBJECT_SELF, "ICNR_Pages") ||    //act page smaller then all pages OR
      GetLocalInt(OBJECT_SELF, "ICNR_ActPage") > 1)                                           //act page greater then 1
    SetLocalInt(OBJECT_SELF, "ICNR_ActPage", GetLocalInt(OBJECT_SELF, "ICNR_ActPage")-1);
}
