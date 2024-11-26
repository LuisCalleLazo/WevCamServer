using System.Text.Json.Serialization;

namespace WebCamServer.Dtos
{
  public class FoundToCreateDto : FoundDetailDto
  {
    [JsonIgnore]
    public DateTime CreateAt { get; set; }
    [JsonIgnore]
    public int CreateUserId { get; set; }

    public FoundToCreateDto()
    {
      CreateAt = DateTime.UtcNow;
    }
  }
}