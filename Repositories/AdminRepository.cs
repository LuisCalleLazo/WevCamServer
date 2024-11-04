using Microsoft.EntityFrameworkCore;
using usr_service.Data;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class AdminRepository : IAdminRepository
  {
    private readonly DataContext _context;

    public AdminRepository(DataContext context)
    {
      _context = context;
    }
    
    public async Task<Admin> GetById(int id) =>
      await _context.Admins.FirstOrDefaultAsync(c => c.Id == id);

    public async Task<Admin> GetByUserId(int userId) =>
      await _context.Admins.FirstOrDefaultAsync(c => c.UserId == userId);
        
    public async Task<List<Admin>> GetList() =>
      await _context.Admins
        .Where(x => x.DeleteAt == DateTime.MinValue)
        .ToListAsync();
        
    public async Task<List<Admin>> GetListDel() =>
      await _context.Admins
        .Where(x => x.DeleteAt != DateTime.MinValue)
        .ToListAsync();
        
    public async Task Create(Admin create)
    {
      await _context.Admins.AddAsync(create);
      await _context.SaveChangesAsync();
    }
    
    public async Task Update(Admin update)
    {
      _context.Admins.Update(update);
      await _context.SaveChangesAsync();
    }
    
    public async Task Drop(Admin drop)
    {
      _context.Admins.Remove(drop);
      await _context.SaveChangesAsync();
    }
  }
}