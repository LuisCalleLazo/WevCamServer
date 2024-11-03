using WebCamServer.Dtos;
using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface IUserRepository
  {
    // User
    Task<User> GetByAuth(AuthLoginDto auth);
    Task<bool> IsDeleted(int id);
    Task<User> GetById(int id);
    Task<User> GetByName(string name);
    Task<User> GetByEmail(string email);
    Task<List<User>> GetAll();
    Task<List<User>> GetAllDel();
    Task Create(User create, Guid salt);
    Task Update(User update);
    Task Drop(User user);


    // Type User
    Task<bool> IsAdmin(int id);
    Task<bool> IsSeeker(int id);


    // UserInfo
    Task<UserInfo> GetInfoById(int id);
    Task<List<UserInfo>> GetInfoAll();
    Task<List<UserInfo>> GetInfoAllDel();
    Task CreateInfo(UserInfo create);
    Task UpdateInfo(UserInfo update);
    Task DropInfo(UserInfo user);
  }
}