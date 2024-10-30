using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  public class Camera : HistoryModel
  {
    public int Id { get; set; }
    public string Code { get; set; }
    public string UbicationMap { get; set; }

    
    public virtual ICollection<FoundVideo> FoundVideos { get; set; }
  }
}