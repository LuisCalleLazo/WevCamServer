
namespace WebCamServer.Dtos
{
  public class AuthResponseDto
  {
    public UserResponseDto User {get; set;}
    public string CurrentToken {get; set;}
    public string RefreshToken {get; set;}
  }
}