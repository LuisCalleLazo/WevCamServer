using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;

namespace WebCamServer.Services.Interfaces
{
  public interface IFileService
  {
    Task UploadLocalFile(MissingToSaveDto save);
    Task<List<FileContentResult>> GetFilesOfFolder(string folder);
    Task<byte[]> GetZipOfFilesOfFolder(string folder);
  }
}