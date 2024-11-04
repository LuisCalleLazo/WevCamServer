using WebCamServer.Dtos;
using WebCamServer.Helpers;

namespace WebCamServer.Services.Interfaces
{
  public interface IMissingService
  {
    Task<MissingResponseDto> RegisterMissing(MissingToCreateDto create);
    bool ValidatePhotos(IFormFile[] photos, MissingPhotosType type, int userId, int missingId);
    Task<bool> SavePhotosMissing(MissingPhotosType type, MissingToPhotosDto missingPhotos);
  }
}