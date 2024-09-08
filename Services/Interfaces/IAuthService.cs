using WebCamServer.Models;
using WebCamServer.Dtos;

namespace WebCamServer.Services.Interfaces
{
  public interface IAuthService
  {
    Task<AuthResponseDto> Authentication(AuthRequestDto auth);
    Task<bool> ValidateRefreshToken(AuthRefreshTokenRequestDto auth, string idUser);
    Task<AuthResponseDto> RefreshToken(AuthRefreshTokenRequestDto auth, string idUser);
    Task<AuthResponseDto> RegisterUser(UserToCreateDto create);
  }
}