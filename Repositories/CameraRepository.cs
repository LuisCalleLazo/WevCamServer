using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class CameraRepository : ICameraRepository
  {
    // private readonly IMongoCollection<Camera> _coll;

    // public CameraRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    // {
    //   var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
    //   _coll = database.GetCollection<Camera>("Camera");
    // }

    // public async Task<List<Camera>> GetAll()
    // {
    //   return await _coll.Find(_ => true).ToListAsync();
    // }

    // public async Task<Camera> GetById(string id)
    // {
    //   return await _coll.Find(entity => entity.Id == id).FirstOrDefaultAsync();
    // }

    // public async Task Create(Camera newEntity)
    // {
    //   await _coll.InsertOneAsync(newEntity);
    // }

    // public async Task Update(string id, Camera updatedEntity)
    // {
    //   await _coll.ReplaceOneAsync(entity => entity.Id == id, updatedEntity);
    // }

    // public async Task Delete(string id)
    // {
    //   await _coll.DeleteOneAsync(entity => entity.Id == id);
    // }

  }
}