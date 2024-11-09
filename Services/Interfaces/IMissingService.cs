using WebCamServer.Dtos;
using WebCamServer.Helpers;

namespace WebCamServer.Services.Interfaces
{
  public interface IMissingService
  {
    Task<MissingResponseDto> RegisterMissing(MissingToCreateDto create);
    bool ValidatePhotos(MissingPhotosType type, int userId, int missingId);
    Task<bool> SavePhotosMissing(MissingPhotosType type, MissingToPhotosDto missingPhotos, int userId);
    bool RemovePhotosError(int userId, int missingId);
    Task<bool> UpdatePhotosMissing(int missingId, MissingPhotosType type);
  }
}