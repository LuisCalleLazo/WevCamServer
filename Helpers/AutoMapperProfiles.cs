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
      CreateMap<UserToCreateDto, UserInfo>();
      CreateMap<User, UserResponseDto>();
      CreateMap<User, UserInfoDto>();
      CreateMap<UserInfo, UserResponseDto>();
    }
  }
}