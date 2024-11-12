using WebCamServer.Models;
using WebCamServer.Repositories;
using WebCamServer.Services.Interfaces;
using WebCamServer.Dtos;
using WebCamServer.Repositories.Interfaces;
using AutoMapper;
using WebCamServer.Security;
using usr_service.Data;
using WebCamServer.Helpers;

namespace WebCamServer.Services
{
  public class AuthService : IAuthService
  {
    private IUserRepository _userRepo;
    private IMapper _mapper;
    private DataContext _context;
    private readonly IConfiguration _config;
    private readonly ITokenRepository _repo;
    
    public AuthService( IUserRepository userRepo, IMapper mapper, IConfiguration config, ITokenRepository repo, DataContext context)
    {
      _mapper = mapper;
      _config = config;
      _userRepo = userRepo;
      _repo = repo;
      _context = context;
    }
    public async Task<AuthResponseDto> Authentication(User user)
    {
      var response = new AuthResponseDto();

      var userInfo = await _userRepo.GetInfoById(user.UserInfoId);
      response.User = _mapper.Map<UserResponseDto>(userInfo);
      response.User.Id = user.Id;
      response.User.Name = user.Name;
      response.User.Email = user.Email;
      response.User.Age = CalculateAge.Get(userInfo.BirthDate);  

      var jwt = _config.GetSection("JwtConfig").Get<AuthJwtDto>();
      if(user == null) return null;

      response.CurrentToken = Jwt.GenerateToken(jwt, user);
      response.RefreshToken = Jwt.GenerateRefreshToken();

      await _repo.DesactiveToken(user.Id);
      await _repo.CreateToken(_mapper.Map<Token>(response), user, jwt.TimeValidMin);
      return response;
    }
    public async Task<AuthResponseDto> Login(AuthLoginDto auth)
    {
      var user = await _userRepo.GetByAuth(auth);
      return await Authentication(user);
    }

    public async Task<bool> ValidateRefreshToken(AuthRefreshTokenDto auth, int idUser)
    {
      var tokenValid = await _repo.GetTokenRefresh(auth, idUser);
      if(tokenValid == null) return false;
      else return true;
    }

    public async Task<AuthResponseDto> RefreshToken(int idUser)
    {
      var user = await _userRepo.GetById(idUser);

      return await Authentication(user);
    }

    public async Task<AuthResponseDto> RegisterUser(UserToCreateDto register)
    {
      var response = new AuthResponseDto();
      
      var user = _mapper.Map<User>(register);
      var userInfo = _mapper.Map<UserInfo>(register);

      var jwt = _config.GetSection("JwtConfig").Get<AuthJwtDto>();
      
      Guid salt = Guid.NewGuid();
      user.Password = PasswordHash.HashPassword(register.Password, salt);
      user.PasswordSalt = salt;

      using (var transaction = await _context.Database.BeginTransactionAsync())
      {
        try
        {
          await _userRepo.CreateInfo(userInfo);
          user.UserInfoId = userInfo.Id;

          await _userRepo.Create(user);

          await transaction.CommitAsync();
        }
        catch (Exception)
        {
          await transaction.RollbackAsync();
          throw;
        }
      }

      var userResponse = _mapper.Map<UserResponseDto>(userInfo);
      userResponse.Id = user.Id;
      userResponse.Email = user.Email;
      userResponse.Name = user.Name;
      userResponse.Age = CalculateAge.Get(userResponse.BirthDate);
      
      response.User = userResponse;
      response.CurrentToken = Jwt.GenerateToken(jwt, user);
      response.RefreshToken = Jwt.GenerateRefreshToken();

      return response;
    }

    public int ValidateToken(string token)
    {
      var jwt = _config.GetSection("JwtConfig").Get<AuthJwtDto>();
      var result =  Jwt.ValidateAndGetUserIdFromToken(token, jwt);
      return result;
    }
  }
}