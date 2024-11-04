using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface IMissingRepository
  {
    Task<Missing> GetById(int id);
    Task<List<Missing>> GetList(int seekerId);
    Task<List<Missing>> GetListDel(int seekerId);
    Task Create(Missing create);
    Task Update(Missing update);
    Task Drop(Missing drop);
  }
}