namespace WebCamServer.Dtos
{
  public class MissingToUpdateDto : MissingDetailDto
  {
    public DateTime UpdateAt { get; set; }
    public MissingToUpdateDto()
    {
      UpdateAt = DateTime.UtcNow;
    }
  }
}