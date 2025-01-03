using WebCamServer.Dtos;

namespace WebCamServer.Services.Interfaces
{
  public interface IFoundVideoService
  {
    Task<List<FoundToListDto>> ListOfVideoMissing(int missingId);
    Task<FoundDetailDto> Create(FoundToCreateDto create);
    Task<byte[]> GetImgsFound(int foundId);
  }
}