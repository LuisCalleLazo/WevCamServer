using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class TokenRepository : ITokenRepository
  {
    // private readonly IMongoCollection<Token> _coll;

    // public TokenRepository(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    // {
    //   var database = mongoClient.GetDatabase(settings.Value.DatabaseName);
    //   _coll = database.GetCollection<Token>("Token");
    // }
    
    // public async Task<Token> CreateToken(Token token, User user, int timeValidMin)
    // {
    //   token.User = user;
    //   token.CreateDate = DateTime.UtcNow;
    //   token.ExpiredDate = DateTime.UtcNow.AddMinutes(timeValidMin);

    //   await _coll.InsertOneAsync(token);

    //   return token;
    // }

    // public async Task<Token> GetTokenRefresh(AuthRefreshTokenRequestDto req, string idUser)
    // {
    //   var filter = Builders<Token>.Filter.And(
    //     Builders<Token>.Filter.Eq(t => t.RefreshToken, req.RefreshToken),
    //     Builders<Token>.Filter.Eq(t => t.CurrentToken, req.TokenExpired),
    //     Builders<Token>.Filter.Eq(t => t.User.Id, idUser),
    //     Builders<Token>.Filter.Eq(t => t.Active, true)
    //   );

    //   var refresToken = await _coll.Find(filter).FirstOrDefaultAsync();

    //   return refresToken;
    // }

    // public async Task DesactiveToken(string userId)
    // {
    //   var filter = Builders<Token>.Filter.Eq(t => t.User.Id, userId);
    //   var sort = Builders<Token>.Sort.Descending(t => t.CreateDate);
      
    //   var token = await _coll.Find(filter).Sort(sort).FirstOrDefaultAsync();

    //   if(token != null)
    //   {
    //     var update = Builders<Token>.Update.Set(t => t.Active, false);
    //     await _coll.UpdateOneAsync(filter, update);
    //   }
    // }

    // public async Task DropToken(string id)
    // {
    //   var filter = Builders<Token>.Filter.Eq(t => t.Id, id);
    //   await _coll.DeleteOneAsync(filter);
    // }

  }
}