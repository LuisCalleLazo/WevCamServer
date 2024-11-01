using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Helpers;
using WebCamServer.Models.RedSocial;

namespace WebCamServer.Repositories
{
  public class VideoPublicationRepository
  {
    
    private readonly IMongoCollection<VideoPublication> _coll;
    
    public VideoPublicationRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    {
      var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
      _coll = database.GetCollection<VideoPublication>("VideoPublications");
    }

    public async Task<List<VideoPublication>> GetAll()
    {
      return await _coll.Find(_ => true).ToListAsync();
    }

    public async Task<VideoPublication> GetById(string id)
    {
      return await _coll.Find(entity => entity.Id == id).FirstOrDefaultAsync();
    }

    public async Task Create(VideoPublication newEntity)
    {
      await _coll.InsertOneAsync(newEntity);
    }

    public async Task Update(string id, VideoPublication updatedEntity)
    {
      await _coll.ReplaceOneAsync(entity => entity.Id == id, updatedEntity);
    }

    public async Task Delete(string id)
    {
      await _coll.DeleteOneAsync(entity => entity.Id == id);
    }
  }
}