using AutoMapper;
using WebCamServer.Dtos;
using WebCamServer.Dtos.Notification;
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

      CreateMap<AuthResponseDto, Token>()
        .ForMember(dest => dest.User, opt => opt.Ignore());;
      CreateMap<Token, AuthResponseDto>();

      CreateMap<Notification, NotificationToListDto>();
      CreateMap<Notification, NotificationDetailDto>();
      CreateMap<NotificationToCreateDto, Notification>();

      CreateMap<MissingToCreateDto, Missing>();
      CreateMap<Missing, MissingResponseDto>();
      CreateMap<Missing, MissingToListDto>();
      CreateMap<Missing, MissingToListSingleDto>();
      CreateMap<Missing, MissingDetailDto>();
      CreateMap<MissingToUpdateDto, Missing>();
    }
  }
}