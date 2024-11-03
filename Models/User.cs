using System.ComponentModel.DataAnnotations.Schema;
using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  [Table("user")]
  public class User : HistoryModel
  {
    public int Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public string Password { get; set; } 
    public Guid PasswordSalt { get; set; }

    // todo: References
    public int UserInfoId { get; set; }


    public virtual UserInfo UserInfo { get; set; }

    public virtual ICollection<Notification> Notifications { get; set; }
    public virtual Seeker Seeker { get; set; }
    public virtual Admin Admin { get; set; }
    public virtual ICollection<Token> Tokens { get; set; }
  }
}