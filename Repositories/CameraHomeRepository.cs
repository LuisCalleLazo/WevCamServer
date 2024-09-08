using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class CameraHomeRepository : ICameraHomeRepository
  {
    private readonly IMongoCollection<CameraHome> _coll;

    public CameraHomeRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    {
      var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
      _coll = database.GetCollection<CameraHome>("CameraHome");
    }

    public async Task<List<CameraHome>> GetAll()
    {
      return await _coll.Find(_ => true).ToListAsync();
    }

    public async Task<CameraHome> GetById(string id)
    {
      return await _coll.Find(entity => entity.Id == id).FirstOrDefaultAsync();
    }

    public async Task Create(CameraHome newEntity)
    {
      await _coll.InsertOneAsync(newEntity);
    }

    public async Task Update(string id, CameraHome updatedEntity)
    {
      await _coll.ReplaceOneAsync(entity => entity.Id == id, updatedEntity);
    }

    public async Task Delete(string id)
    {
      await _coll.DeleteOneAsync(entity => entity.Id == id);
    }

  }
}