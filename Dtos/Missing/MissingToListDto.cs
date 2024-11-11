namespace WebCamServer.Dtos
{
  public class MissingToListDto : MissingDetailDto
  {
    public int Id { get; set; }
    
    // Photos
    public bool PhotosFront { get; set; }
    public bool PhotosLeft { get; set; }
    public bool PhotosRigth { get; set; }
  }
  
  public class MissingToFileDto
  {
    public int Id { get; set; }
    public string NameFile { get; set; }
    public IFormFile Asset { get; set; }
  }
}