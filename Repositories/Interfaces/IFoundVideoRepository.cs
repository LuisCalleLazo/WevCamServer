using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface IFoundVideoRepository
  {
    
    Task<FoundVideo> GetById(int id);
    Task<List<FoundVideo>> GetByMissingId(int missingId);
    Task<List<FoundVideo>> GetList(int missingId);
    Task<List<FoundVideo>> GetListDel(int missingId);
    Task Create(FoundVideo create);
    Task Update(FoundVideo update);
    Task Drop(FoundVideo drop);
  }
}