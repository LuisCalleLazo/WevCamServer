using WebCamServer.Models.RedSocial;

namespace WebCamServer.Repositories.Interfaces
{
  public interface IVideoPublicationRepository
  {
    Task<List<VideoPublication>> GetAll();
    Task<VideoPublication> GetById(string id);
    Task Create(VideoPublication newEntity);
    Task Update(string id, VideoPublication updatedEntity);
    Task Delete(string id);
  }
}