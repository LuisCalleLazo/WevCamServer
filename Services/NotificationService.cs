using System.Net.WebSockets;
using System.Text;
using AutoMapper;
using WebCamServer.Dtos.Notification;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services.Interfaces;
using System.Text.Json;
using System.Collections.Concurrent;

namespace WebCamServer.Services
{
  public class NotificationService : INotificationService
  {
    private readonly INotificationRepository _repo;
    private readonly IMapper _mapper;
    private static readonly ConcurrentDictionary<int, WebSocket> ActiveWebSockets = new ConcurrentDictionary<int, WebSocket>();
    
    public NotificationService(INotificationRepository repo, IMapper mapper)
    {
      _repo = repo;
      _mapper = mapper;
    }

    public async Task<List<NotificationToListDto>> GetList(int userId) =>
      _mapper.Map<List<NotificationToListDto>>(await _repo.GetList(userId));

    public async Task<NotificationDetailDto> Create(NotificationToCreateDto create)
    {
      var created = _mapper.Map<Notification>(create);
      await _repo.Create(created);

      var list = await GetList(created.UserId);
      var newItem = _mapper.Map<NotificationToListDto>(created);
      list.Add(newItem);

      await SendNotificationAsync(created.UserId, list);

      return _mapper.Map<NotificationDetailDto>(created);
    }

    public async Task<NotificationDetailDto> Update(NotificationToUpdateDto update)
    {
      var updated = await _repo.GetById(update.Id);

      updated.Title = update.Title;
      updated.Description = update.Description;
      updated.LinkAction = update.LinkAction;
      updated.UpdateAt = update.UpdateAt;
      updated.Type = update.Type;
      
      await _repo.Update(updated);

      return _mapper.Map<NotificationDetailDto>(updated);
    }

    public async Task NotificationConnection(WebSocket webSocket, int userId)
    {
      ActiveWebSockets[userId] = webSocket;

      await SendInitialNotificationsAsync(userId);
      var buffer = new byte[1024 * 4];
      while (webSocket.State == WebSocketState.Open)
      {
        var result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
        if (result.MessageType == WebSocketMessageType.Close)
        {
          ActiveWebSockets.TryRemove(userId, out _);
          await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closed by the server", CancellationToken.None);
        }
      }
    }

    private async Task SendNotificationAsync(int userId, List<NotificationToListDto> notifications)
    {
      if (ActiveWebSockets.TryGetValue(userId, out var webSocket) && webSocket.State == WebSocketState.Open)
      {
        var message = JsonSerializer.Serialize(notifications);
        var messageBuffer = Encoding.UTF8.GetBytes(message);

        await webSocket.SendAsync(new ArraySegment<byte>(messageBuffer), WebSocketMessageType.Text, true, CancellationToken.None);
      }
    }

    public async Task SendInitialNotificationsAsync(int userId)
    {
      var notifications = await GetList(userId);
      await SendNotificationAsync(userId, notifications);
    }
  }
}