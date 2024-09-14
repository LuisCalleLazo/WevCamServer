using Microsoft.AspNetCore.Mvc;
using System.Net.WebSockets;
using WebCamServer.Services.Interfaces;

[Route("stream")]
[ApiController]
public class StreamController : ControllerBase
{
  private readonly ICameraService _camServ;
  private readonly IControlsService _conServ;

  public StreamController(ICameraService camServ, IControlsService conServ)
  {
    _camServ = camServ;
    _conServ = conServ;
  }

  [HttpGet("camera/esp32-cam")]
  public async Task WsEsp32Camera()
  {
    Console.WriteLine("INTENTO");
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
      Console.WriteLine("Se conecto!!!");
      WebSocket webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
      await _camServ.WatchCamera(webSocket);
    }
    else
    {
      Console.WriteLine("Lo rechazo!!!");
      HttpContext.Response.StatusCode = 400;
    }
  }
  
  [HttpGet("controls-camera")]
  public async Task WsControls()
  {
    if (HttpContext.WebSockets.IsWebSocketRequest)
    {
      WebSocket webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
      await _conServ.ControlsOfCamera(webSocket);
    }
    else
    {
      HttpContext.Response.StatusCode = 400;
    }
  }
}