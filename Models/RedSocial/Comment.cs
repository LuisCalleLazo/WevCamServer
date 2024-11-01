namespace WebCamServer.Models.RedSocial
{
  public class Comment 
  {
    public string Id { get; set; }
    public string Comments { get; set; }
    public string Image { get; set; }
    public string Video { get; set; }
    public DateTime Date { get; set; }

    // todo: References
    public int PublicationId { get; set; }
    public int CommentId { get; set; }
  }
}