namespace WebCamServer.Dtos
{
  public class UserResponseDto : UserInfoDto
  {
    public int Id { get; set; }
    public string Name {get; set;} 
    public string Ci {get; set;} 
  }
}