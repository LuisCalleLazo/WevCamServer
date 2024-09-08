using WebCamServer.Dtos;
using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface IUserRepository
  {
    Task<User> GetUserByAuth(AuthRequestDto auth);
    Task<List<User>> GetAll();
    Task<User> GetById(string id);
    Task Create(User newEntity);
    Task Update(string id, User updatedEntity);
    Task Delete(string id);
  }
}