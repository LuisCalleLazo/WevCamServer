using Microsoft.EntityFrameworkCore;
using usr_service.Data;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class SeekerRepository : ISeekerRepository
  {
    private readonly DataContext _context;

    public SeekerRepository(DataContext context)
    {
      _context = context;
    }

    public async Task<Seeker> GetById(int id) =>
      await _context.Seekers.FirstOrDefaultAsync(c => c.Id == id);

    public async Task<Seeker> GetByUserId(int userId) =>
      await _context.Seekers.FirstOrDefaultAsync(c => c.UserId == userId);
        
    public async Task<List<Seeker>> GetList() =>
      await _context.Seekers
        .Where(x => x.DeleteAt == DateTime.MinValue)
        .ToListAsync();
        
    public async Task<List<Seeker>> GetListDel() =>
      await _context.Seekers
        .Where(x => x.DeleteAt != DateTime.MinValue)
        .ToListAsync();
        
    public async Task Create(Seeker create)
    {
      await _context.Seekers.AddAsync(create);
      await _context.SaveChangesAsync();
    }
    
    public async Task Update(Seeker update)
    {
      _context.Seekers.Update(update);
      await _context.SaveChangesAsync();
    }
    
    public async Task Drop(Seeker drop)
    {
      _context.Seekers.Remove(drop);
      await _context.SaveChangesAsync();
    }

  }
}