using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class RecordingRepository : IRecordingRepository
  {
    private readonly IMongoCollection<Recording> _coll;

    public RecordingRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    {
      var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
      _coll = database.GetCollection<Recording>("Recording");
    }

    public async Task<List<Recording>> GetAll()
    {
      return await _coll.Find(_ => true).ToListAsync();
    }

    public async Task<Recording> GetById(string id)
    {
      return await _coll.Find(entity => entity.Id == id).FirstOrDefaultAsync();
    }

    public async Task Create(Recording newEntity)
    {
      await _coll.InsertOneAsync(newEntity);
    }

    public async Task Update(string id, Recording updatedEntity)
    {
      await _coll.ReplaceOneAsync(entity => entity.Id == id, updatedEntity);
    }

    public async Task Delete(string id)
    {
      await _coll.DeleteOneAsync(entity => entity.Id == id);
    }

  }
}