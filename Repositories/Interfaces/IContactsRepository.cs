using WebCamServer.Models;

namespace WebCamServer.Repositories.Interfaces
{
  public interface IContactsRepository
  {
    Task<Contacts> GetById(int id);
    Task<List<Contacts>> GetList(int seekerId);
    Task<List<Contacts>> GetListDel(int seekerId);
    Task Create(Contacts create);
    Task Update(Contacts update);
    Task Drop(Contacts drop);
  }
}