using System.Net.WebSockets;

namespace WebCamServer.Services.Interfaces
{
  public interface ICameraService
  {
    Task Esp32CamConnection(WebSocket webSocket);
    Task WatchCamera(WebSocket webSocket);
    Task CloseAllConnections();
  }
}