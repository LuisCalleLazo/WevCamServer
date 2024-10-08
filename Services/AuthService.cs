using WebCamServer.Models;
using WebCamServer.Repositories;
using WebCamServer.Services.Interfaces;
using WebCamServer.Dtos;
using WebCamServer.Repositories.Interfaces;
using AutoMapper;
using WebCamServer.Security;

namespace WebCamServer.Services
{
  public class AuthService : IAuthService
  {
    private IUserRepository _userRepo;
    private IMapper _mapper;
    private readonly IConfiguration _config;
    private readonly ITokenRepository _repo;
    public AuthService( IUserRepository userRepo, IMapper mapper, IConfiguration config, ITokenRepository repo)
    {
      _mapper = mapper;
      _config = config;
      _userRepo = userRepo;
      _repo = repo;
    }

    public async Task<AuthResponseDto> Authentication(AuthRequestDto auth)
    {
      var response = new AuthResponseDto();

      var user = await _userRepo.GetUserByAuth(auth);
      response.User = user;    
      
      var jwt = _config.GetSection("JwtConfig").Get<AuthJwtDto>();
      if(user == null) return null;

      response.CurrentToken = Jwt.GenerateToken(jwt, response.User);
      response.RefreshToken = Jwt.GenerateRefreshToken();

      await _repo.DesactiveToken(user.Id);
      await _repo.CreateToken(_mapper.Map<Token>(response), user, jwt.TimeValidMin);
      return response;
    }
    public async Task<bool> ValidateRefreshToken(AuthRefreshTokenRequestDto auth, string idUser)
    {
      var tokenValid = await _repo.GetTokenRefresh(auth, idUser);
      if(tokenValid == null) return false;
      else return true;
    }
    public async Task<AuthResponseDto> RefreshToken(AuthRefreshTokenRequestDto auth, string idUser)
    {
      var response = new AuthResponseDto();
      var jwt = _config.GetSection("JwtConfig").Get<AuthJwtDto>();

      var user = await _userRepo.GetById(idUser);

      response.User = user;
      response.CurrentToken = Jwt.GenerateToken(jwt, response.User);
      response.RefreshToken = Jwt.GenerateRefreshToken();

      await _repo.DesactiveToken(user.Id);
      await _repo.CreateToken(_mapper.Map<Token>(response), user, jwt.TimeValidMin);

      return response;
    }
    public async Task<AuthResponseDto> RegisterUser(UserToCreateDto register)
    {
      var response = new AuthResponseDto();
      var user = _mapper.Map<User>(register);
      var jwt = _config.GetSection("JwtConfig").Get<AuthJwtDto>();
      
      Guid salt = Guid.NewGuid();
      user.Password = PasswordHash.HashPassword(register.Password, salt);
      user.PasswordSalt = salt;

      await _userRepo.Create(user);
      
      response.User = user;
      response.CurrentToken = Jwt.GenerateToken(jwt, response.User);
      response.RefreshToken = Jwt.GenerateRefreshToken();

      return response;
    }
  }
}