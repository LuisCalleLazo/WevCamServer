using WebCamServer.Models;
using WebCamServer.Dtos;

namespace WebCamServer.Services.Interfaces
{
  public interface IAuthService
  {
    Task<AuthResponseDto> Authentication(User user);
    Task<AuthResponseDto> Login(AuthLoginDto auth);
    Task<bool> ValidateRefreshToken(AuthRefreshTokenDto auth, int idUser);
    Task<AuthResponseDto> RefreshToken(int idUser);
    Task<AuthResponseDto> RegisterUser(UserToCreateDto create);
    int ValidateToken(string token);
  }
}