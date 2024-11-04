using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface ICameraRepository
  {
    Task<Camera> GetByCode(string code);
    Task<List<Camera>> GetListDel();
    Task<List<Camera>> GetList();
    Task<Camera> GetById(int id);
    Task Create(Camera create);
    Task Update(Camera update);
    Task Drop(Camera drop);
  }
}