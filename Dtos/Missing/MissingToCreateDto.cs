using System.Text.Json.Serialization;

namespace WebCamServer.Dtos
{
  public class MissingToCreateDto : MissingDetailDto
  {
    public DateTime CreateAt { get; set; }
    public int SeekerId { get; set; }
    
    [JsonIgnore]
    public string DirPhotos { get; set; }
    
    public MissingToCreateDto()
    {
      CreateAt = DateTime.UtcNow;
    }
  }
}