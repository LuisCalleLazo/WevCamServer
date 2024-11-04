using Microsoft.EntityFrameworkCore;
using usr_service.Data;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class NotificationRepository : INotificationRepository
  {
    private readonly DataContext _context;
    public NotificationRepository(DataContext context)
    {
      _context = context;
    }

    public async Task<Notification> GetById(int id) =>
      await _context.Notifications.FirstOrDefaultAsync(x => x.Id == id);

    public async Task<List<Notification>> GetList(int userId) =>
      await _context.Notifications
        .Where(x => x.DeleteAt == DateTime.MinValue && x.UserId == userId)
        .ToListAsync();
        
    public async Task<List<Notification>> GetListDel(int userId) =>
      await _context.Notifications
        .Where(x => x.DeleteAt != DateTime.MinValue && x.UserId == userId)
        .ToListAsync();
        
    public async Task Create(Notification create)
    {
      await _context.Notifications.AddAsync(create);
      await _context.SaveChangesAsync();
    }
    
    public async Task Update(Notification create)
    {
      _context.Notifications.Update(create);
      await _context.SaveChangesAsync();
    }
    
    public async Task Drop(Notification create)
    {
      _context.Notifications.Remove(create);
      await _context.SaveChangesAsync();
    }
  }
}