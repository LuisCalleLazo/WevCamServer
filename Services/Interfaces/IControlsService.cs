using System.Net.WebSockets;

namespace WebCamServer.Services.Interfaces
{
  public interface IControlsService
  {
    Task ControlsOfCamera(WebSocket webSocket);
  }
}