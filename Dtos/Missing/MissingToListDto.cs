namespace WebCamServer.Dtos
{
  public class MissingToListDto : MissingDetailDto
  {
    public int Id { get; set; }
  }
  
  public class MissingToFileDto
  {
    public int Id { get; set; }
    public string NameFile { get; set; }
    public IFormFile Asset { get; set; }
  }
}