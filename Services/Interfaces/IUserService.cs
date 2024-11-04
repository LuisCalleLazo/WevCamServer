using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Models;

namespace WebCamServer.Services.Interfaces
{
  public interface IUserService
  {
    Task<UserResponseDto> Create(UserToCreateDto create);
    Task<UserResponseDto> UpdateUser(int userId, UserToUpdateDto update);
    Task<UserResponseDto> GetById(int userId);
    // Task<List<UserDto>> GetList();
    // Task Delete(string userId);
    Task<UserResponseDto> GetByName(string name);
    Task<UserResponseDto> GetByEmail(string email);
    Task<bool> ExistName(string name);
    Task<bool> ExistEmail(string email);
    Task<bool> Drop(int userId);
  }
}