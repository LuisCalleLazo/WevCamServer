using WebCamServer.Models;
using WebCamServer.Repositories;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class AuthService : IAuthService
  {
    private readonly UserRepository _repo;
    public AuthService(UserRepository repo)
    {
      _repo = repo;
    }

    public async Task<List<User>> GetAllEntitiesAsync()
    {
      return await _repo.GetAllAsync();
    }

    public async Task<User> GetEntityByIdAsync(string id)
    {
        return await _repo.GetByIdAsync(id);
    }

    public async Task CreateEntityAsync(User entity)
    {
      entity.CreateAt = DateTime.UtcNow;
      await _repo.CreateAsync(entity);
    }

    public async Task UpdateEntityAsync(string id, User updatedEntity)
    {
      await _repo.UpdateAsync(id, updatedEntity);
    }

    public async Task DeleteEntityAsync(string id)
    {
      await _repo.DeleteAsync(id);
    }
  }
}