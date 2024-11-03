using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  public class UserInfo : HistoryModel
  {
    public int Id { get; set; }
    public string Name { get; set; }
    public string FirstName { get; set; }
    public string DadLastName { get; set; }
    public string MomLastName { get; set; }
    public DateTime BirthDate { get; set; }
    public string Email { get; set; }
    public string City { get; set; }
    public string Ci { get; set; }

    public virtual User User { get; set; }
  }
}