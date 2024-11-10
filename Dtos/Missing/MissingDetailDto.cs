using System.Text.Json.Serialization;

namespace WebCamServer.Dtos
{
  public class MissingDetailDto
  {
    public DateTime BirthDate { get; set; }
    public DateTime MissingDate { get; set; }
    public string FullName { get; set; }
    public double Size { get; set; }
    public bool Gender { get; set; }
    public string Description { get; set; }
    public string  LastSeenMap { get; set; }
    public bool Found { get; set; }
  }
}