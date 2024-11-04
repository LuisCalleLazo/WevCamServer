using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using usr_service.Data;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class CameraRepository : ICameraRepository
  {
    private readonly DataContext _context;

    public CameraRepository(DataContext context)
    {
      _context = context;
    }

    public async Task<Camera> GetByCode(string code) =>
      await _context.Cameras
        .FirstOrDefaultAsync(x => x.Code == code);
        
    public async Task<Camera> GetById(int id) =>
      await _context.Cameras.FirstOrDefaultAsync(x => x.Id == id);

    public async Task<List<Camera>> GetList() =>
      await _context.Cameras
        .Where(x => x.DeleteAt == DateTime.MinValue)
        .ToListAsync();
        
    public async Task<List<Camera>> GetListDel() =>
      await _context.Cameras
        .Where(x => x.DeleteAt != DateTime.MinValue)
        .ToListAsync();

    public async Task Create(Camera create)
    {
      await  _context.Cameras.AddAsync(create);
      await _context.SaveChangesAsync();
    }

    public async Task Update(Camera update)
    {
      _context.Cameras.Update(update);
      await _context.SaveChangesAsync();
    }

    public async Task Drop(Camera drop)
    { 
      _context.Cameras.Remove(drop);
      await _context.SaveChangesAsync();
    }

  }
}