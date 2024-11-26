using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Models;

namespace WebCamServer.Services.Interfaces
{
  public interface IFileService
  {
    Task UploadLocalFile(MissingToSaveDto save, string path);
    Task<List<FileContentResult>> GetFilesOfFolder(string folder);
    Task<byte[]> GetZipOfFilesOfFolder(string folder);
    List<string> GetImagesOfFound(FoundVideo foundVideo);
    Task<byte[]> GetZipOfFilesOfListFiles(List<string> files);
    List<string> GetImagesOfRange(DateOnly date, TimeOnly init, TimeOnly end);
  }
}