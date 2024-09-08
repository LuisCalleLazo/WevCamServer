using System.Net.WebSockets;

namespace WebCamServer.Services.Interfaces
{
  public interface ICameraService
  {
    Task HandleWebSocketConnection(WebSocket webSocket);
  }
}