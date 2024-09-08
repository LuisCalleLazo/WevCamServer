using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface IUserRepository
  {
    Task<List<User>> GetAll();
    Task<User> GetById(string id);
    Task Create(User newEntity);
    Task Update(string id, User updatedEntity);
    Task Delete(string id);
  }
}