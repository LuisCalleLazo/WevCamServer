using Microsoft.EntityFrameworkCore;
using usr_service.Data;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class MissingRepository : IMissingRepository
  {
    private readonly DataContext _context;

    public MissingRepository(DataContext context)
    {
      _context = context;
    }
    public async Task<Missing> GetById(int id) =>
      await _context.Missings
        .Where(c => c.Id == id)
        .FirstOrDefaultAsync();
        
    public async Task<List<Missing>> GetList(int seekerId) =>
      await _context.Missings
        .Where(x => x.DeleteAt == DateTime.MinValue && x.SeekerId == seekerId)
        .ToListAsync();
        
    public async Task<List<Missing>> GetListDel(int seekerId) =>
      await _context.Missings
        .Where(x => x.DeleteAt != DateTime.MinValue && x.SeekerId == seekerId)
        .ToListAsync();
        
    public async Task Create(Missing create)
    {
      await _context.Missings.AddAsync(create);
      await _context.SaveChangesAsync();
    }
    
    public async Task Update(Missing update)
    {
      _context.Missings.Update(update);
      await _context.SaveChangesAsync();
    }
    
    public async Task Drop(Missing drop)
    {
      _context.Missings.Remove(drop);
      await _context.SaveChangesAsync();
    }
  }
}