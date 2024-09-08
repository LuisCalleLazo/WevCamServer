using Microsoft.AspNetCore.Mvc;
using System.Net.WebSockets;

[Route("api/stream")]
[ApiController]
public class StreamController : ControllerBase
{
  [HttpGet("camera")]
  public async Task WsCamera()
  {
    if (HttpContext.WebSockets.IsWebSocketRequest)
    {
      WebSocket webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
      await HandleWebSocketConnection(webSocket);
    }
    else
    {
      HttpContext.Response.StatusCode = 400; // Bad Request
    }
  }

  private async Task HandleWebSocketConnection(WebSocket webSocket)
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
  
  [HttpGet("controls")]
  public async Task WsControls()
  {
    if (HttpContext.WebSockets.IsWebSocketRequest)
    {
      WebSocket webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
      await HandleWebSocketConnection(webSocket);
    }
    else
    {
      HttpContext.Response.StatusCode = 400; // Bad Request
    }
  }
}