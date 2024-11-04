using System.Text.Json.Serialization;
using WebCamServer.Helpers;

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

  public class MissingToPhotosDto
  {
    public IFormFile[] Photos { get; set; }
    public int MissingId { get; set; }
    public int UserId { get; set; }
  }

  public class MissingToSaveDto
  {
    public IFormFile File { get; set; }
    public int UserId { get; set; }
    public int MissingId { get; set; }
    public string NameFile { get; set; }
    public MissingPhotosType Type { get; set; }
  }
}