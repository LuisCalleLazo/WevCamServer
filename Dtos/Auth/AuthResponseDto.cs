
namespace WebCamServer.Dtos
{
  public class AuthResponseDto
  {
    public UserInfoDto User {get; set;}
    public string CurrentToken {get; set;}
    public string RefreshToken {get; set;}
  }
}