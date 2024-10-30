using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  public class Missing : HistoryModel
  {
    public int Id { get; set; }
    public string DirPhotos { get; set; }
    public DateTime BirthDate { get; set; }
    public string FullName { get; set; }
    public double Size { get; set; }
    public string Description { get; set; }
    public string  LastSeenMap { get; set; }
    public bool Found { get; set; }
    public int SeekerId { get; set; }

    // todo: References
    public virtual Seeker Seeker { get; set; }
    public virtual ICollection<FoundVideo> FoundVideos { get; set; }
  }
}