using System.Text.Json.Serialization;

namespace WebCamServer.Dtos.Notification
{
  public class NotificationToCreateDto : NotificationDetailDto
  {
    [JsonIgnore]
    public DateTime CreateAt { get; set; }
    
    [JsonIgnore]
    public int UserId { get; set; }

    public NotificationToCreateDto()
    {
      CreateAt = DateTime.UtcNow;
    }
  }
}