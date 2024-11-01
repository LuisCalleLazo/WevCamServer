using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class CameraActivityRepository : ICameraActivityRepository
  {
    // private readonly IMongoCollection<CameraActivity> _coll;

    // public CameraActivityRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    // {
    //   var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
    //   _coll = database.GetCollection<CameraActivity>("CameraActivity");
    // }

    // public async Task<List<CameraActivity>> GetAll()
    // {
    //   return await _coll.Find(_ => true).ToListAsync();
    // }

    // public async Task<CameraActivity> GetById(string id)
    // {
    //   return await _coll.Find(entity => entity.Id == id).FirstOrDefaultAsync();
    // }

    // public async Task Create(CameraActivity newEntity)
    // {
    //   await _coll.InsertOneAsync(newEntity);
    // }

    // public async Task Update(string id, CameraActivity updatedEntity)
    // {
    //   await _coll.ReplaceOneAsync(entity => entity.Id == id, updatedEntity);
    // }

    // public async Task Delete(string id)
    // {
    //   await _coll.DeleteOneAsync(entity => entity.Id == id);
    // }

  }
}