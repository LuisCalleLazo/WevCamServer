
using System.ComponentModel.DataAnnotations.Schema;

namespace WebCamServer.Models
{
  [Table("token")]
  public class Token
  {
    public int Id { get; set; }
    public string CurrentToken { get; set;} 
    public string RefreshToken { get; set;} 
    public DateTime CreateDate { get; set;}
    public DateTime ExpiredDate { get; set;}
    public bool Active { get; set;}

    // todo: references
    public int UserId { get; set; }


    public User User {get; set;}
  }
}