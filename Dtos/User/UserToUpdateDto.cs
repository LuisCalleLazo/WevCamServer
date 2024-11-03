namespace WebCamServer.Dtos
{
  public class UserToUpdateDto : UserInfoDto
  {
    public string Ci {get; set;} 
    public DateTime UpdateAt { get; set; }
    public UserToUpdateDto()
    {
      UpdateAt = DateTime.UtcNow;
    }
  }
}