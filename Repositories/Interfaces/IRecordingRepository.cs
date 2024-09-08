using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface IRecordingRepository
  {
    Task<List<Recording>> GetAll();
    Task<Recording> GetById(string id);
    Task Create(Recording newEntity);
    Task Update(string id, Recording updatedEntity);
    Task Delete(string id);
  }
}