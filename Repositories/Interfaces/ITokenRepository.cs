using WebCamServer.Dtos;
using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface ITokenRepository
  {
    Task<Token> CreateToken(Token token, User user, int timeValidMin);
    Task<Token> GetTokenRefresh(AuthRefreshTokenDto auth, int userId);
    Task DesactiveToken(int userId);
    Task DropToken(int id);
    
  }
}