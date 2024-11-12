using System.Net.WebSockets;
using WebCamServer.Dtos.Notification;

namespace WebCamServer.Services.Interfaces
{
  public interface INotificationService
  {
    Task<List<NotificationToListDto>> GetList(int userId);
    Task<NotificationDetailDto> Create(NotificationToCreateDto create);
    Task<NotificationDetailDto> Update(NotificationToUpdateDto update);
    Task NotificationConnection(WebSocket webSocket, int userId);
  }
}