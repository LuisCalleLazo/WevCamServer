namespace WebCamServer.Dtos.Notification
{
  public class NotificationToCreateDto : NotificationDetailDto
  {
    public DateTime CreateAt { get; set; }
    public int UserId { get; set; }

    public NotificationToCreateDto()
    {
      CreateAt = DateTime.UtcNow;
    }
  }
}