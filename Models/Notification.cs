using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  public class Notification : HistoryModel
  {
    public int Id { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public string LinkAction { get; set; }
    public NotificationType Type { get; set; }

    // todo: References
    public int UserId { get; set; }

    public virtual User User { get; set; }
  }

  public enum NotificationType
  {
    Message, Alert, VideoMissing
  }
}