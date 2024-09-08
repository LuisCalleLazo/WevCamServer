using WebCamServer.Models;
using WebCamServer.Repositories;
using WebCamServer.Services.Interfaces;
using WebCamServer.Dtos;
using WebCamServer.Repositories.Interfaces;

namespace WebCamServer.Services
{
  public class AuthService : IAuthService
  {
    private IUserRepository _userRepo;
    public AuthService()
    {
    }

    // public async Task<AuthResponseDto> Authentication(AuthRequestDto auth)
    // {
    //   var response = new AuthResponseDto();

    //   var user = await _userRepo.GetUserByAuth(auth);
    //   var userInfo = _mapper.Map<UserResponseDto>(await _userRepo.GetUserInfoById(user.Id));

    //   userInfo.Name = user.Name;
    //   userInfo.Email = user.Email;

    //   response.User = userInfo;    
      
    //   var jwt = _config.GetSection("JwtConfig").Get<AuthJwtDto>();
    //   if(user == null) return null;

    //   bool isAdmin = await _userRepo.IsAdmin(user.Id);
    //   bool isWorker = await _userRepo.IsWorker(user.Id);
    //   bool isCustomer = await _userRepo.IsCustomer(user.Id);
    //   bool isPartner = await _userRepo.IsPartner(user.Id);
    //   var roles = await _rolRepo.GetRolsForAuth(user.Id);

    //   response.CurrentToken = JwtHelper.GenerateToken(jwt, response.User, isAdmin, isWorker, isCustomer, isPartner,roles);
    //   response.RefreshToken = JwtHelper.GenerateRefreshToken();

    //   await _repo.DesactiveToken(user.Id);
    //   await _repo.CreateToken(_mapper.Map<Token>(response), user.Id, jwt.TimeValidMin);
    //   // await _userRepo.CreateLogLogin(log);
    //   return response;
    //   return new AuthResponseDto();
    // }
    // public async Task<bool> ValidateRefreshToken(AuthRefreshTokenRequestDto auth, int idUser)
    // {
    //   return true;
    // }
    // public async Task<AuthResponseDto> RefreshToken(AuthRefreshTokenRequestDto auth, int idUser)
    // {
    //   return new AuthResponseDto();
    // }
    // public async Task<AuthResponseDto> RegisterUser(UserToCreateDto create)
    // {
    //   return new AuthResponseDto();
    // }
  }
}