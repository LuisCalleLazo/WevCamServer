using Microsoft.AspNetCore.Mvc;
using System.Net.WebSockets;
using WebCamServer.Services.Interfaces;

[Route("stream")]
[ApiController]
public class StreamController : ControllerBase
{
  private readonly ICameraService _camServ;

  public StreamController(ICameraService camServ)
  {
    _camServ = camServ;
  }


  [HttpGet("camera")]
  public async Task WsCamera()
  {
    if (HttpContext.WebSockets.IsWebSocketRequest)
    {
      WebSocket webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
      await _camServ.HandleWebSocketConnection(webSocket);
    }
    else
    {
      HttpContext.Response.StatusCode = 400; // Bad Request
    }
  }
  
  [HttpGet("controls")]
  public async Task WsControls()
  {
    if (HttpContext.WebSockets.IsWebSocketRequest)
    {
      WebSocket webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
      // await HandleWebSocketConnection(webSocket);
    }
    else
    {
      HttpContext.Response.StatusCode = 400; // Bad Request
    }
  }
}