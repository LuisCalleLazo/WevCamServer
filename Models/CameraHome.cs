using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  public class CameraHome : HistoryModel
  {
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public Camera Camera { get; set; }
    public User User { get; set; }
  }
}