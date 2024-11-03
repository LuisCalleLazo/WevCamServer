using AutoMapper;
using WebCamServer.Dtos;
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

    // public async Task<User>

    public async Task<UserResponseDto> UpdateUser(int userId, UserToUpdateDto update)
    {
      var user = await _repo.GetInfoById(userId);
      user.FirstName = update.FirstName;
      user.DadLastName = update.DadLastName;
      user.MomLastName = update.MomLastName;
      user.Email = update.Email;
      user.City = update.City;

      await _repo.UpdateInfo(user);

      return _mapper.Map<UserResponseDto>(update);
    }

    public async Task<UserResponseDto> GetById(int userId) => _mapper.Map<UserResponseDto>(await _repo.GetById(userId));
    
    public async Task<List<UserResponseDto>> GetList() => _mapper.Map<List<UserResponseDto>>(await _repo.GetAll());
  }
}