using Microsoft.EntityFrameworkCore;
using usr_service.Data;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class ContactsRepository : IContactsRepository
  {
    private readonly DataContext _context;
    public ContactsRepository(DataContext context)
    {
      _context = context;
    }

    public async Task<Contacts> GetById(int id) =>
      await _context.Contacts
        .Where(c => c.Id == id)
        .FirstOrDefaultAsync();
        
    public async Task<List<Contacts>> GetList(int seekerId) =>
      await _context.Contacts
        .Where(x => x.DeleteAt == DateTime.MinValue && x.SeekerId == seekerId)
        .ToListAsync();
        
    public async Task<List<Contacts>> GetListDel(int seekerId) =>
      await _context.Contacts
        .Where(x => x.DeleteAt != DateTime.MinValue && x.SeekerId == seekerId)
        .ToListAsync();
        
    public async Task Create(Contacts create)
    {
      await _context.Contacts.AddAsync(create);
      await _context.SaveChangesAsync();
    }
    
    public async Task Update(Contacts update)
    {
      _context.Contacts.Update(update);
      await _context.SaveChangesAsync();
    }
    
    public async Task Drop(Contacts drop)
    {
      _context.Contacts.Remove(drop);
      await _context.SaveChangesAsync();
    }
  }
}