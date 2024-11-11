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

  [HttpGet("camera/esp32-cam")]
  public async Task WsEsp32Camera()
  {
    if (HttpContext.WebSockets.IsWebSocketRequest)
    {
      WebSocket webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
      await _camServ.Esp32CamConnection(webSocket);
    }
    else
    {
      HttpContext.Response.StatusCode = 400;
    }
  }
  
  [HttpGet("camera/watch")]
  public async Task WsWatchCamera()
  {
    if (HttpContext.WebSockets.IsWebSocketRequest)
    {
      WebSocket webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
      await _camServ.WatchCamera(webSocket);
    }
    else
    {
      HttpContext.Response.StatusCode = 400;
    }
  }
}