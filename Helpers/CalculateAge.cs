namespace WebCamServer.Helpers
{
  public static class CalculateAge
  {
    public static int Get(DateTime birthDate)
    {
      DateTime dateCurrent = DateTime.Today;
      int age = dateCurrent.Year - birthDate.Year;

      if (birthDate.Date > dateCurrent.AddYears(-age)) age--;

      return age;
    }
  }
}