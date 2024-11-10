using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using MongoDB.Driver;
using usr_service.Data;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Repositories
{
  public class TokenRepository : ITokenRepository
  {
    private readonly DataContext _context;
    public TokenRepository(DataContext context)
    {
      _context = context;
    }
    
    public async Task<Token> CreateToken(Token token, User user, int timeValidMin)
    {
      token.User = user;
      token.CreateDate = DateTime.UtcNow;
      token.ExpiredDate = DateTime.UtcNow.AddMinutes(timeValidMin);
      token.Active =  true;

      await _context.Tokens.AddAsync(token);
      await _context.SaveChangesAsync();

      return token;
    }

    public async Task<Token> GetTokenRefresh(AuthRefreshTokenDto req, int userId) =>
      await _context.Tokens
        .FirstOrDefaultAsync
        (r => 
          r.RefreshToken == req.RefreshToken && 
          r.CurrentToken== req.TokenExpired && 
          r.UserId == userId 
          && r.Active == true
        );

    public async Task DesactiveToken(int userId)
    {
      var token = await _context.Tokens
        .Where(t => t.UserId == userId)
        .OrderByDescending(t => t.CreateDate)
        .FirstOrDefaultAsync();

      if(token != null)
      {
        token.Active = false;
        _context.Tokens.Update(token);

        await _context.SaveChangesAsync();
      }
    }

    public async Task DropToken(int id)
    {
      var token = await _context.Tokens.Where(t => t.Id == id).FirstOrDefaultAsync();

      _context.Tokens.Remove(token);
      await _context.SaveChangesAsync();
    }
  }
}