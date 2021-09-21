void main()
{
  object oPlc = CreateObject(OBJECT_TYPE_PLACEABLE, "icnr_spawner", GetLocation(OBJECT_SELF));

  SendMessageToPC(GetFirstPC(), "Hier ist nichts mehr zu holen.");
}
