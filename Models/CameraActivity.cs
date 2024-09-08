using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  public class CameraActivity : HistoryModel
  {
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string Id { get; set; }
    public double Duration { get; set; }
    public bool Notified { get; set; }
    public bool Called { get; set; }
    public Camera Camera { get; set; }
    public User User { get; set; }
  }
}