using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Security;

namespace WebCamServer.Repositories
{
  public class UserRepository : IUserRepository
  {
    // private readonly IMongoCollection<User> _coll;

    // public UserRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    // {
    //   var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
    //   _coll = database.GetCollection<User>("User");
    // }

    // public async Task<User> GetUserByAuth(AuthRequestDto auth)
    // {
    //   var filter = Builders<User>.Filter.Or(
    //       Builders<User>.Filter.Eq(u => u.Name, auth.NameOrGmail),
    //       Builders<User>.Filter.Eq(u => u.Email, auth.NameOrGmail)
    //   );

      
    //   var user = await _coll.Find(filter).FirstOrDefaultAsync();

    //   if (user == null) return null;

      
    //   if (!PasswordHash.VerifyPassword(user.Password, auth.Password, user.PasswordSalt))
    //       return null;

    //   return user;
    // }
    // public async Task<List<User>> GetAll()
    // {
    //   return await _coll.Find(_ => true).ToListAsync();
    // }

    // public async Task<User> GetById(string id)
    // {
    //   return await _coll.Find(entity => entity.Id == id).FirstOrDefaultAsync();
    // }

    // public async Task Create(User newEntity)
    // {
    //   await _coll.InsertOneAsync(newEntity);
    // }

    // public async Task Update(string id, User updatedEntity)
    // {
    //   await _coll.ReplaceOneAsync(entity => entity.Id == id, updatedEntity);
    // }

    // public async Task Delete(string id)
    // {
    //   await _coll.DeleteOneAsync(entity => entity.Id == id);
    // }

  }
}