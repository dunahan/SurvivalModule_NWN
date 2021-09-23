void main()
{
  if (GetIsObjectValid(GetFirstItemInInventory()))
  {
    SetLocalInt(OBJECT_SELF, "BUILD_ActPage", 1);                                //starting page
    ActionStartConversation(GetLastClosedBy(), "build_dlg_workb", TRUE, FALSE);  //start convo
  }
}
