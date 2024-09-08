namespace WebCamServer.Services.Interfaces
{
  public interface IDetectIAService
  {
    bool IsAuthorized(string capture);
    bool HasHumanoidShape(string capture);
  }
}