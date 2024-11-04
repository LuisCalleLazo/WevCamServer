namespace WebCamServer.Dtos.Notification
{
  public class NotificationToUpdateDto : NotificationDetailDto
  {
    public int Id { get; set; }
    public DateTime UpdateAt { get; set; }

    public NotificationToUpdateDto()
    {
      UpdateAt = DateTime.UtcNow;
    }
  }
}