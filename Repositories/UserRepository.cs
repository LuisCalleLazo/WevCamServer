using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Helpers;
using WebCamServer.Models;

namespace WebCamServer.Repositories
{
  public class UserRepository
  {
    private readonly IMongoCollection<User> _userColl;

    public UserRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    {
      var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
      _userColl = database.GetCollection<User>("User");
    }

    public async Task<List<User>> GetAllAsync()
    {
      return await _userColl.Find(_ => true).ToListAsync();
    }

    public async Task<User> GetByIdAsync(string id)
    {
      return await _userColl.Find(entity => entity.Id == id).FirstOrDefaultAsync();
    }

    public async Task CreateAsync(User newEntity)
    {
      await _userColl.InsertOneAsync(newEntity);
    }

    public async Task UpdateAsync(string id, User updatedEntity)
    {
      await _userColl.ReplaceOneAsync(entity => entity.Id == id, updatedEntity);
    }

    public async Task DeleteAsync(string id)
    {
      await _userColl.DeleteOneAsync(entity => entity.Id == id);
    }

  }
}