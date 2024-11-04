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

  public static class ConstantsValueSystem
  {
    public static string NameFilePythonDetectFacePose() => "IA/DetectFace/detect_face_pose.py";

    public static string GetStrMissingPhotosType(MissingPhotosType type)
    {
      switch (type)
      {
        case MissingPhotosType.Left:
          return "left";
          
        case MissingPhotosType.Rigth:
          return "rigth";

        case MissingPhotosType.Front:
          return "front";
        
        default:
          return "front";
      }
    }
  }
}