using System.Net.WebSockets;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class CameraService : ICameraService
  {
    public CameraService()
    {

    }

    public async Task Esp32CamConnection(WebSocket webSocket)
    {
      var buffer = new byte[1024 * 4];

      while (webSocket.State == WebSocketState.Open)
      {
        var result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
        if (result.MessageType == WebSocketMessageType.Close)
        {
          Console.WriteLine("Se cerro la conexion");
          await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closing", CancellationToken.None);
        }
        else
        {
          Console.WriteLine("Se envio el mensaje");
          await webSocket.SendAsync(new ArraySegment<byte>(buffer, 0, result.Count), result.MessageType, result.EndOfMessage, CancellationToken.None);
        }
      }
    }
    
    public async Task WatchCamera(WebSocket webSocket)
    {
      var buffer = new byte[1024 * 4];

      while (webSocket.State == WebSocketState.Open)
      {
        var result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
        if (result.MessageType == WebSocketMessageType.Close)
        {
          Console.WriteLine("Se cerro la conexion");
          await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closing", CancellationToken.None);
        }
        else
        {
          Console.WriteLine("Se envio el mensaje");
          await webSocket.SendAsync(new ArraySegment<byte>(buffer, 0, result.Count), result.MessageType, result.EndOfMessage, CancellationToken.None);
        }
      }
    }
  }
}