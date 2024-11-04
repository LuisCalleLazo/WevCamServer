using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface ISeekerRepository
  {
    Task<Seeker> GetById(int id);
    Task<Seeker> GetByUserId(int userId);
    Task<List<Seeker>> GetList();
    Task<List<Seeker>> GetListDel();
    Task Create(Seeker create);
    Task Update(Seeker update);
    Task Drop(Seeker drop);
  }
}