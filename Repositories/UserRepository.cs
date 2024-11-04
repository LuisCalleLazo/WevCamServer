using Microsoft.EntityFrameworkCore;
using MongoDB.Driver;
using usr_service.Data;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Security;

namespace WebCamServer.Repositories
{
  public class UserRepository : IUserRepository
  {
    private readonly DataContext _context;

    public UserRepository(DataContext context)
    {
      _context = context;
    }

    public async Task<User> GetByAuth(AuthLoginDto auth)
    {
      var user = await _context.Users
        .Where(u => u.Name == auth.NameOrGmail || u.Email == auth.NameOrGmail)
        .FirstOrDefaultAsync();

      if (user == null) return null;

      if(!PasswordHash.VerifyPassword(user.Password, auth.Password, user.PasswordSalt)) return null;

      return user;
    }

    
    public async Task<bool> IsAdmin(int id)
    {
      var user = await _context.Admins.Where(x => x.UserId == id).FirstOrDefaultAsync();

      if(user == null) return false;
      else return true;
    } 

    public async Task<bool> IsSeeker(int id)
    {
      var user = await _context.Seekers.Where(x => x.UserId == id).FirstOrDefaultAsync();

      if(user == null) return false;
      else return true;
    }


    public async Task<bool> IsDeleted(int id) =>
      await _context.Users
        .FirstOrDefaultAsync(
          x => x.Id == id && 
          x.DeleteAt != DateTime.MinValue
        ) != null ? true : false;

    public async Task<User> GetById(int id) =>
      await _context.Users
        .Where(u => u.Id == id)
        .FirstOrDefaultAsync();
    
    public async Task<User> GetByName(string name) =>
      await _context.Users
        .Where(u => u.Name == name)
        .FirstOrDefaultAsync();
    
    public async Task<User> GetByEmail(string email) => 
      await _context.Users
        .Where(u => u.Email == email)
        .FirstOrDefaultAsync();

    public async Task<List<User>> GetAll() =>
      await _context.Users
        .Where(u => u.DeleteAt == DateTime.MinValue)
        .Include(u => u.UserInfo)
        .ToListAsync();

    public async Task<List<User>> GetAllDel() =>
      await _context.Users
        .Where(u => u.DeleteAt != DateTime.MinValue)
        .Include(u => u.UserInfo)
        .ToListAsync();

    public async Task Create(User create)
    { 
      await _context.Users.AddAsync(create);
      await _context.SaveChangesAsync();
    }

    public async Task Update(User update)
    {
      _context.Users.Update(update);
      await _context.SaveChangesAsync();
    }

    public async Task Drop(User user)
    { 
      _context.Users.Remove(user);
      await _context.SaveChangesAsync();
    }
    
    public async Task<UserInfo> GetInfoById(int id) =>
      await _context.UserInfos
        .Where(a => a.Id == id)
        .FirstOrDefaultAsync();

    public async Task<List<UserInfo>> GetInfoAll() =>
      await _context.UserInfos
        .Where(u => u.DeleteAt == DateTime.MinValue)
        .ToListAsync();
        
    public async Task<List<UserInfo>> GetInfoAllDel() =>
      await _context.UserInfos
        .Where(u => u.DeleteAt != DateTime.MinValue)
        .ToListAsync();

    public async Task CreateInfo(UserInfo create)
    {
      await _context.UserInfos.AddAsync(create);
      await _context.SaveChangesAsync();
    }

    public async Task UpdateInfo(UserInfo update)
    {
      _context.UserInfos.Update(update);
      await _context.SaveChangesAsync();
    }

    public async Task DropInfo(UserInfo user)
    {
      _context.UserInfos.Remove(user);
      await _context.SaveChangesAsync();
    }

  }
}