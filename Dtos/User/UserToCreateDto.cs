using WebCamServer.Helpers;

namespace WebCamServer.Dtos
{
  public class UserToCreateDto : UserInfoDto
  {
    public string Name {get; set;} 
    public string Password { get; set; } 
    public string Ci {get; set;}
    public UserType Type { get; set; }
    public DateTime CreateAt {get; set;}
    public UserToCreateDto()
    {
      CreateAt = DateTime.UtcNow;
    }
  }
}