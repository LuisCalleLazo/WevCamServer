using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Helpers;
using WebCamServer.Models.RedSocial;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class CommentRepository : ICommentRepository
  {
    private readonly IMongoCollection<Comment> _coll;
    
    public CommentRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    {
      var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
      _coll = database.GetCollection<Comment>("Comments");
    }

    public async Task<List<Comment>> GetAll()
    {
      return await _coll.Find(_ => true).ToListAsync();
    }

    public async Task<Comment> GetById(string id)
    {
      return await _coll.Find(entity => entity.Id == id).FirstOrDefaultAsync();
    }

    public async Task Create(Comment newEntity)
    {
      await _coll.InsertOneAsync(newEntity);
    }

    public async Task Update(string id, Comment updatedEntity)
    {
      await _coll.ReplaceOneAsync(entity => entity.Id == id, updatedEntity);
    }

    public async Task Delete(string id)
    {
      await _coll.DeleteOneAsync(entity => entity.Id == id);
    }
  }
}