using System.ComponentModel.DataAnnotations.Schema;
using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  [Table("contacts")]
  public class Contacts : HistoryModel
  {
    public int Id { get; set; }
    public string Description { get; set; }
    public string Value { get; set; }
    public ContactsType Type { get; set; }

    // todo: References
    public int SeekerId {get; set;}

    public virtual Seeker Seeker { get; set; }
  }

  public enum ContactsType
  {
    Number, Phone, Email
  }
}