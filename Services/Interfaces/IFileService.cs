using WebCamServer.Dtos;

namespace WebCamServer.Services.Interfaces
{
  public interface IFileService
  {
    Task UploadLocalFile(MissingToSaveDto save);
  }
}