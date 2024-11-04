using AutoMapper;
using usr_service.Data;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Security;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class UserService : IUserService
  {
    private readonly IUserRepository _repo;
    private readonly IMapper _mapper;
    private readonly DataContext _context;
    public UserService(IUserRepository repo, IMapper mapper, DataContext context)
    {
      _repo = repo;
      _mapper = mapper;
      _context = context;
    }

    public async Task<UserResponseDto> Create(UserToCreateDto create)
    {
            
      var user = _mapper.Map<User>(create);
      var userInfo = _mapper.Map<UserInfo>(create);
      
      Guid salt = Guid.NewGuid();
      user.Password = PasswordHash.HashPassword(create.Password, salt);
      user.PasswordSalt = salt;

      using (var transaction = await _context.Database.BeginTransactionAsync())
      {
        try
        {
          await _repo.CreateInfo(userInfo);
          user.UserInfoId = userInfo.Id;

          await _repo.Create(user);

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
      
      return userResponse;
    }

    public async Task<UserResponseDto> UpdateUser(int userId, UserToUpdateDto update)
    {
      var user = await _repo.GetById(userId);
      
      var updated = await _repo.GetInfoById(user.UserInfoId);
      updated.FirstName = update.FirstName;
      updated.DadLastName = update.DadLastName;
      updated.MomLastName = update.MomLastName;
      updated.BirthDate = update.BirthDate;
      updated.City = update.City;
      updated.Ci = update.Ci;
      updated.UpdateAt = update.UpdateAt;

      await _repo.UpdateInfo(updated);

      var response = _mapper.Map<UserResponseDto>(updated);
      response.Name = updated.User.Name;
      response.Email = updated.User.Email;
      response.Age = CalculateAge.Get(updated.BirthDate);

      return response;
    }

    public async Task<UserResponseDto> GetById(int userId) 
    {
      var user = await _repo.GetById(userId);
      var userInfo = await _repo.GetInfoById(user.UserInfoId);

      var response = _mapper.Map<UserResponseDto>(userInfo);
      response.Name = userInfo.User.Name;
      response.Email = userInfo.User.Email;
      response.Age = CalculateAge.Get(userInfo.BirthDate);

      return response;
    }
    
    public async Task<UserResponseDto> GetByName(string name) 
    {
      var user = await _repo.GetByName(name);
      var userInfo = await _repo.GetInfoById(user.UserInfoId);

      var response = _mapper.Map<UserResponseDto>(userInfo);
      response.Name = userInfo.User.Name;
      response.Email = userInfo.User.Email;

      return response;
    }

    
    public async Task<UserResponseDto> GetByEmail(string email) 
    {
      var user = await _repo.GetByEmail(email);
      var userInfo = await _repo.GetInfoById(user.UserInfoId);
      
      var response = _mapper.Map<UserResponseDto>(userInfo);
      response.Name = userInfo.User.Name;
      response.Email = userInfo.User.Email;

      return response;
    }
    
    public async Task<List<UserResponseDto>> GetList() => _mapper.Map<List<UserResponseDto>>(await _repo.GetAll());
  }
}