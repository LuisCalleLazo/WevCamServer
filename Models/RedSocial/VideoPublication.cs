namespace WebCamServer.Models.RedSocial
{
  public class VideoPublication
  {
    public string Title { get; set; }
    public string Description { get; set; }
    public TimeOnly InitVideo { get; set; }
    public TimeOnly EndVideo { get; set; }
    public DateOnly Date { get; set; }

    // todo: References
    public int FoundVideoId { get; set; }
  }
}