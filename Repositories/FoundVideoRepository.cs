using Microsoft.EntityFrameworkCore;
using usr_service.Data;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class FoundVideoRepository : IFoundVideoRepository
  {
    private readonly DataContext _context;
    public FoundVideoRepository(DataContext context)
    {
      _context = context;
    }

    public async Task<FoundVideo> GetById(int id) =>
      await _context.FoundVideos
        .Where(c => c.Id == id)
        .FirstOrDefaultAsync();
        
    public async Task<List<FoundVideo>> GetList(int missingId) =>
      await _context.FoundVideos
        .Where(x => x.DeleteAt == DateTime.MinValue && x.MissingId == missingId)
        .ToListAsync();
        
    public async Task<List<FoundVideo>> GetListDel(int missingId) =>
      await _context.FoundVideos
        .Where(x => x.DeleteAt != DateTime.MinValue && x.MissingId == missingId)
        .ToListAsync();
        
    public async Task Create(FoundVideo create)
    {
      await _context.FoundVideos.AddAsync(create);
      await _context.SaveChangesAsync();
    }
    
    public async Task Update(FoundVideo update)
    {
      _context.FoundVideos.Update(update);
      await _context.SaveChangesAsync();
    }
    
    public async Task Drop(FoundVideo drop)
    {
      _context.FoundVideos.Remove(drop);
      await _context.SaveChangesAsync();
    }
  }
}