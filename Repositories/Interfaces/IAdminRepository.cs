using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface IAdminRepository
  {
    Task<Admin> GetById(int id);
    Task<Admin> GetByUserId(int userId);
    Task<List<Admin>> GetList();
    Task<List<Admin>> GetListDel();
    Task Create(Admin create);
    Task Update(Admin update);
    Task Drop(Admin drop);
  }
}