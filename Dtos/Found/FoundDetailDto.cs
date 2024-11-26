namespace WebCamServer.Dtos
{
  public class FoundDetailDto
  {
    public TimeOnly InitVideo { get; set; }
    public TimeOnly EndVideo { get; set; }
    public DateOnly Date { get; set; }
    public int CameraId { get; set; }
    public int MissingId { get; set; }
  }
}