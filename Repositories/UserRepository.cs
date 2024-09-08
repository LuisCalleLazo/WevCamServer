using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class UserRepository : IUserRepository
  {
    private readonly IMongoCollection<User> _coll;

    public UserRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    {
      var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
      _coll = database.GetCollection<User>("User");
    }

    public async Task<List<User>> GetAll()
    {
      return await _coll.Find(_ => true).ToListAsync();
    }

    public async Task<User> GetById(string id)
    {
      return await _coll.Find(entity => entity.Id == id).FirstOrDefaultAsync();
    }

    public async Task Create(User newEntity)
    {
      await _coll.InsertOneAsync(newEntity);
    }

    public async Task Update(string id, User updatedEntity)
    {
      await _coll.ReplaceOneAsync(entity => entity.Id == id, updatedEntity);
    }

    public async Task Delete(string id)
    {
      await _coll.DeleteOneAsync(entity => entity.Id == id);
    }

  }
}