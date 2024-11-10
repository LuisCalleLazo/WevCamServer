using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace WebCamServer.Dtos
{
  public class MissingToCreateDto : MissingDetailDto
  {
    
    [JsonIgnore]
    public DateTime CreateAt { get; set; }
    
    [JsonIgnore]
    public string DirPhotos { get; set; }
    
    [JsonIgnore]
    public int SeekerId { get; set; }
    
    public MissingToCreateDto()
    {
      CreateAt = DateTime.UtcNow;
    }
  }

  public class MissingToPhotosDto
  {
    public IFormFile[] Photos { get; set; }
    public int MissingId { get; set; }
  }

  public class MissingToSaveDto
  {
    public IFormFile File { get; set; }
    public int UserId { get; set; }
    public int MissingId { get; set; }
    public string NameFile { get; set; }
    public string Type { get; set; }
  }
}