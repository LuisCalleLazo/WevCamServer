using AutoMapper;
using WebCamServer.Dtos;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class UserService : IUserService
  {
    // private readonly IUserRepository _repo;
    // private readonly IMapper _mapper;
    // public UserService(IUserRepository repo, IMapper mapper)
    // {
    //   _repo = repo;
    //   _mapper = mapper;
    // }

    // public async Task<UserDto> UpdateUser(string userId, UserDto update)
    // {
    //   var user = await _repo.GetById(userId);
    //   user.Name = update.Name;
    //   user.FirstName = update.FirstName;
    //   user.DadLastName = update.DadLastName;
    //   user.MomLastName = update.MomLastName;
    //   user.Age = update.Age;
    //   user.Email = update.Email;
    //   user.City = update.City;

    //   await _repo.Update(userId, user);

    //   return update;
    // }

    // public async Task<UserDto> GetById(string userId) => _mapper.Map<UserDto>(await _repo.GetById(userId));
    
    // public async Task<List<UserDto>> GetList() => _mapper.Map<List<UserDto>>(await _repo.GetAll());
    
    // public async Task Delete(string userId) => await _repo.Delete(userId);
  }
}