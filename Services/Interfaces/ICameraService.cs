using System.Net.WebSockets;
using WebCamServer.Dtos;
using WebCamServer.Models;

namespace WebCamServer.Services.Interfaces
{
  public interface ICameraService
  {
    Task Esp32CamConnection(WebSocket webSocket);
    Task WatchCamera(WebSocket webSocket);
    Task CloseAllConnections();
    Task<CameraDetailDto> Create(CameraToCreateDto create);
  }
}