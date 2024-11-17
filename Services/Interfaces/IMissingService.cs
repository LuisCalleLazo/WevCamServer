using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Helpers;

namespace WebCamServer.Services.Interfaces
{
  public interface IMissingService
  {
    Task<MissingResponseDto> RegisterMissing(MissingToCreateDto create);
    Task<bool> ValidatePhotos(MissingPhotosType type, int userId, int missingId);
    Task<bool> SavePhotosMissing(MissingPhotosType type, MissingToPhotosDto missingPhotos, int userId);
    bool RemovePhotosError(int userId, int missingId);
    Task<bool> UpdatePhotosMissing(int missingId, MissingPhotosType type);
    Task<List<MissingToListDto>> GetListMissings(int seekerId);
    Task<byte[]> GetZipFilesMissing(int userId, int missingId,MissingPhotosType type);
    Task<MissingDetailDto> UpdateMissing(MissingToUpdateDto update);
    Task<bool> DeleteMissing(int missingId);
  }
}