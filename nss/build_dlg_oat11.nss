void main()
{
  if (GetLocalInt(OBJECT_SELF, "ICNR_ActPage") < GetLocalInt(OBJECT_SELF, "ICNR_Pages"))    //only add if end of book not reached
    SetLocalInt(OBJECT_SELF, "ICNR_ActPage", GetLocalInt(OBJECT_SELF, "ICNR_ActPage")+1);
}
