using WebCamServer.Dtos;
using WebCamServer.Helpers;

namespace WebCamServer.Services.Interfaces
{
  public interface IMissingService
  {
    Task<MissingResponseDto> RegisterMissing(MissingToCreateDto create);
    Task<bool> ValidatePhotos(IFormFile[] photos, MissingPhotosType type);
  }
}