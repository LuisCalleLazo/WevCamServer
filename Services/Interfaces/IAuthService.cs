using WebCamServer.Models;
using WebCamServer.Dtos;

namespace WebCamServer.Services.Interfaces
{
  public interface IAuthService
  {
    Task<AuthResponseDto> Authentication(AuthLoginDto auth);
    Task<bool> ValidateRefreshToken(AuthRefreshTokenDto auth, int idUser);
    // Task<AuthResponseDto> RefreshToken(AuthRefreshTokenRequestDto auth, string idUser);
    Task<AuthResponseDto> RegisterUser(UserToCreateDto create);
  }
}