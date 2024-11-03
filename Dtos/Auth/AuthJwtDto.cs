namespace WebCamServer.Dtos
{
  public class AuthJwtDto
  {
    public string Key { get; set; } 
    public string Issuer { get; set; } 
    public string Audience { get; set; } 
    public string Subject { get; set; } 
    public int TimeValidMin {get; set;}
  }
}