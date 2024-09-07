using WebCamServer.Models;

namespace WebCamServer.Services.Interfaces
{
  public interface IAuthService
  {
    Task<List<User>> GetAllEntitiesAsync();
    Task<User> GetEntityByIdAsync(string id);
    Task CreateEntityAsync(User entity);
    Task UpdateEntityAsync(string id, User updatedEntity);
    Task DeleteEntityAsync(string id);
  }
}