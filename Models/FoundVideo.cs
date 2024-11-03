using System.ComponentModel.DataAnnotations.Schema;
using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  [Table("found_video")]
  public class FoundVideo : HistoryModel
  {
    public int Id { get; set; }
    public TimeOnly InitVideo { get; set; }
    public TimeOnly EndVideo { get; set; }
    public DateOnly Date { get; set; }

    // todo: References
    public int CameraId { get; set; }
    public int MissingId { get; set; }

    public virtual Camera Camera { get; set; }
    public virtual Missing Missing { get; set; }
  }
}