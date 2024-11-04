using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface INotificationRepository
  {
    Task<Notification> GetById(int id);
    Task<List<Notification>> GetList(int userId);
    Task<List<Notification>> GetListDel(int userId);
    Task Create(Notification create);
    Task Update(Notification create);
    Task Drop(Notification create);
  }
}