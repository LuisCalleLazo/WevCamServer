using System.Net.WebSockets;
using System.Text;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class ControlsService : IControlsService
  {
    public ControlsService()
    {

    }
    
    public async Task ControlsOfCamera(WebSocket webSocket)
    {
      var buffer = new byte[1024 * 4];

      while (webSocket.State == WebSocketState.Open)
      {
        var result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
        if (result.MessageType == WebSocketMessageType.Close)
        {
          await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closing", CancellationToken.None);
        }
        else
        {
          var clientMsg = Encoding.UTF8.GetString(buffer, 0, result.Count);
          var serverResponse = $"RESPUESTA DEL SERVIDOR: {clientMsg}";

          var bufferRes = Encoding.UTF8.GetBytes(serverResponse);
          
          
          await webSocket.SendAsync(
            new ArraySegment<byte>(bufferRes), 
            WebSocketMessageType.Text, 
            true, 
            CancellationToken.None
            );
        }
      }
    }
  }
}