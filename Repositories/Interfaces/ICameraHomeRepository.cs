using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface ICameraHomeRepository
  {
    Task<List<CameraHome>> GetAll();
    Task<CameraHome> GetById(string id);
    Task Create(CameraHome newEntity);
    Task Update(string id, CameraHome updatedEntity);
    Task Delete(string id);
  }
}