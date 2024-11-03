using AutoMapper;
using WebCamServer.Dtos;
using WebCamServer.Models;


namespace WebCamServer.Helpers
{
  public class AutoMapperProfiles : Profile
  {
    public AutoMapperProfiles()
    {
      CreateMap<UserToCreateDto, User>();
      CreateMap<User, UserResponseDto>();
    }
  }
}