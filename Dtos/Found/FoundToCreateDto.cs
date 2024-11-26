namespace WebCamServer.Dtos
{
  public class FoundToCreateDto : FoundDetailDto
  {
    public DateTime CreateAt { get; set; }
    public int CreateUserId { get; set; }

    public FoundToCreateDto()
    {
      CreateAt = DateTime.UtcNow;
    }
  }
}