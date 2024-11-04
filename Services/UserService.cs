using AutoMapper;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class UserService : IUserService
  {
    private readonly IUserRepository _repo;
    private readonly IMapper _mapper;
    public UserService(IUserRepository repo, IMapper mapper)
    {
      _repo = repo;
      _mapper = mapper;
    }

    public async Task<UserResponseDto> UpdateUser(int userId, UserToUpdateDto update)
    {
      var user = await _repo.GetInfoById(userId);
      user.FirstName = update.FirstName;
      user.DadLastName = update.DadLastName;
      user.MomLastName = update.MomLastName;
      user.BirthDate = update.BirthDate;
      user.City = update.City;
      user.Ci = update.Ci;

      await _repo.UpdateInfo(user);

      var response = _mapper.Map<UserResponseDto>(user);
      response.Name = user.User.Name;
      response.Email = user.User.Email;

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