using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  public class Camera : HistoryModel
  {
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string Id { get; set; }
    public Guid Code {get; set;}
    public CameraStatus Status {get; set;}
  }

  public enum CameraStatus
  {
    ONLINE, STOP, OFFLINE
  }
}