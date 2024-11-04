using WebCamServer.Models;

namespace WebCamServer.Dtos.Notification
{
  public class NotificationDetailDto
  {
    public string Title { get; set; }
    public string Description { get; set; }
    public string LinkAction { get; set; }
    public NotificationType Type { get; set; }
  }
}