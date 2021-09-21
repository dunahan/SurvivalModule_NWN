void main()
{
  if (GetIsObjectValid(GetFirstItemInInventory()))
  {
    SetLocalInt(OBJECT_SELF, "ICNR_ActPage", 1);                                //starting page
    ActionStartConversation(GetLastClosedBy(), "icnr_workbench", TRUE, FALSE);  //start convo
  }
}
