using System.Text.Json.Serialization;

namespace WebCamServer.Dtos
{
  public class MissingToUpdateDto : MissingDetailDto
  {
    [JsonIgnore]
    public DateTime UpdateAt { get; set; }
    
    [JsonIgnore]
    public int MissingId { get; set; }
    [JsonIgnore]
    public int SeekerId { get; set; }
    public MissingToUpdateDto()
    {
      UpdateAt = DateTime.UtcNow;
    }
  }
}