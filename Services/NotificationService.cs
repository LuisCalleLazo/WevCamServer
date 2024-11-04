using AutoMapper;
using WebCamServer.Dtos.Notification;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class NotificationService : INotificationService
  {
    private readonly INotificationRepository _repo;
    private readonly IMapper _mapper;
    
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
  }
}