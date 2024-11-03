namespace WebCamServer.Dtos
{
  public class UserInfoDto
  {
    public string FirstName { get; set; }
    public string DadLastName { get; set; }
    public string MomLastName { get; set; }
    public DateTime BirthDate { get; set; }
    public string Email { get; set; }
    public string City { get; set; }

    // Data Null
    public int? Age { get; set; }
  }
}