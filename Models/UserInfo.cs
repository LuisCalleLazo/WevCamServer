using System.ComponentModel.DataAnnotations.Schema;
using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  [Table("user_info")]
  public class UserInfo : HistoryModel
  {
    public int Id { get; set; }
    public string FirstName { get; set; }
    public string DadLastName { get; set; }
    public string MomLastName { get; set; }
    public DateTime BirthDate { get; set; }
    public string City { get; set; }
    public string Ci { get; set; }

    public virtual User User { get; set; }
  }
}