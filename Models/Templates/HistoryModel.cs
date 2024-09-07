namespace WebCamServer.Models.Templates
{
  public class HistoryModel
  {
    public DateTime CreateAt { get; set; }
    public DateTime UpdateAt { get; set; }
    public DateTime DeleteAt { get; set; }

    public int CreateUserId { get; set; }
    public int UpdateUserId { get; set; }
    public int DeleteUserId { get; set; }
  }
}