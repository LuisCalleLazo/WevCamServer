using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace WebCamServer.Models
{
  public class Token
  {
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string Id { get; set; }
    public string CurrentToken { get; set;} 
    public string RefreshToken { get; set;} 
    public DateTime CreateDate { get; set;}
    public DateTime ExpiredDate { get; set;}
    public bool Active { get; set;}
    public User User {get; set;}
  }
}