using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using WebCamServer.Models.Templates;

namespace WebCamServer.Models
{
  public class Recording : HistoryModel
  {
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string Id { get; set; }
    public DateTime Date { get; set; }
    public string VideoLink { get; set; }
    public double Duration { get; set; }
    public Camera Camera { get; set; }
  }
}