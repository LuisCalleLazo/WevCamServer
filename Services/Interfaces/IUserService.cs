using WebCamServer.Dtos;
using WebCamServer.Models;

namespace WebCamServer.Services.Interfaces
{
  public interface IUserService
  {
    // Task<UserDto> UpdateUser(string userId, UserDto update);
    Task<UserResponseDto> GetById(int userId);
    // Task<List<UserDto>> GetList();
    // Task Delete(string userId);
    Task<UserResponseDto> GetByName(string name);
    Task<UserResponseDto> GetByEmail(string email);
  }
}