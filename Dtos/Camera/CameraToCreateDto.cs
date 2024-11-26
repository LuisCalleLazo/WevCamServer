using System.Text.Json.Serialization;

namespace WebCamServer.Dtos
{
  public class CameraToCreateDto : CameraDetailDto
  {
    [JsonIgnore]
    public DateTime CreateAt { get; set; }
    [JsonIgnore]
    public int CreateUserId { get; set; }
    public CameraToCreateDto()
    {
      CreateAt = DateTime.UtcNow;
    }
  }
}