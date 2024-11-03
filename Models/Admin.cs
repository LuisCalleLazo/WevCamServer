using System.ComponentModel.DataAnnotations.Schema;
using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  [Table("admin")]
  public class Admin : HistoryModel
  {
    public int Id { get; set; }
    
    // todo: References
    public int UserId { get; set; }

    public virtual User User { get; set; }
  }
}