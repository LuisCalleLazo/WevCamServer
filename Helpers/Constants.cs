namespace WebCamServer.Helpers
{
  public enum UserType
  {
    Admin, Seeker
  }

  public enum MissingPhotosType
  {
    Left, Rigth, Front
  }

  public enum ResultPredictionType
  {
    Nothing, Found, NotFound
  }

  public static class ConstantsValueSystem
  {
    public static string NameFolderPython() => "IA";
    public static string NameFolderMissigns() => "wwwroot/Missing";
    public static string GetStrMissingPhotosType(MissingPhotosType type)
    {
      switch (type)
      {
        case MissingPhotosType.Left:
          return "left";
          
        case MissingPhotosType.Rigth:
          return "right";

        case MissingPhotosType.Front:
          return "front";
        
        default:
          return "front";
      }
    }
  }
}