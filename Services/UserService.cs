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
    private readonly IAdminRepository _adminRepo;
    private readonly ISeekerRepository _seekerRepo;
    private readonly IMapper _mapper;
    private readonly DataContext _context;
    public UserService(IUserRepository repo, IMapper mapper, DataContext context, IAdminRepository adminRepo, ISeekerRepository seekerRepo)
    {
      _repo = repo;
      _mapper = mapper;
      _context = context;
      _adminRepo = adminRepo;
      _seekerRepo = seekerRepo;
    }

    public UserResponseDto UserResponse(UserInfo userInfo)
    {
      var userResponse = _mapper.Map<UserResponseDto>(userInfo);
      userResponse.Id = userInfo.User.Id;
      userResponse.Email = userInfo.User.Email;
      userResponse.Name = userInfo.User.Name;
      userResponse.Age = CalculateAge.Get(userResponse.BirthDate);
      
      return userResponse;
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

          switch (create.Type)
          {
            case UserType.Admin:
              await ConvertToAdmin(user.Id);
              break;

            case UserType.Seeker:
              await ConvertToSeeker(user.Id);
              break;

            default:
              await ConvertToSeeker(user.Id);
              break;
          }

          await transaction.CommitAsync();
        }
        catch (Exception)
        {
          await transaction.RollbackAsync();
          throw;
        }
      }

      return UserResponse(userInfo);
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

      return UserResponse(updated);
    }

    public async Task<bool> UserExist(int userId)
    {
      var user = await _repo.GetById(userId);

      if (user == null) return true;
      if(user.DeleteAt != DateTime.MinValue) return true;

      return false;
    }

    public async Task<UserResponseDto> GetById(int userId) 
    {
      var user = await _repo.GetById(userId);
      var userInfo = await _repo.GetInfoById(user.UserInfoId);

      return UserResponse(userInfo);
    }
    
    public async Task<bool> ExistName(string name) =>
      await _repo.GetByName(name) != null ? true : false;

    public async Task<bool> ExistEmail(string email) =>
      await _repo.GetByEmail(email) != null ? true : false;
    
    public async Task<UserResponseDto> GetByName(string name) 
    {
      var user = await _repo.GetByName(name);
      var userInfo = await _repo.GetInfoById(user.UserInfoId);

      return UserResponse(userInfo);
    }

    
    public async Task<UserResponseDto> GetByEmail(string email) 
    {
      var user = await _repo.GetByEmail(email);
      var userInfo = await _repo.GetInfoById(user.UserInfoId);
      
      return UserResponse(userInfo);
    }
    
    public async Task<List<UserResponseDto>> GetList() => _mapper.Map<List<UserResponseDto>>(await _repo.GetAll());

    public async Task<bool> Drop(int userId)
    {
      
      var user = await _repo.GetById(userId);
      var admin = await _adminRepo.GetByUserId(userId);
      var seeker = await _seekerRepo.GetByUserId(userId);
      var userInfo = await _repo.GetInfoById(user.UserInfoId);

      using (var transaction = await _context.Database.BeginTransactionAsync())
      {
        try
        {
          if(admin != null) await _adminRepo.Drop(admin);
          if(seeker != null) await _seekerRepo.Drop(seeker);;

          await _repo.Drop(user);
          await _repo.DropInfo(userInfo);

          await transaction.CommitAsync();
        }
        catch (Exception)
        {
          await transaction.RollbackAsync();
          throw;
        }
      }

      return true;
    }

    public async Task<Admin> ConvertToAdmin(int userId)
    {
      var admin = new Admin { UserId = userId };
      await _adminRepo.Create(admin);
      return admin;
    }

    public async Task<Seeker> ConvertToSeeker(int userId)
    {
      var seeker = new Seeker { UserId = userId };
      await _seekerRepo.Create(seeker);
      return seeker;
    }
  }
}