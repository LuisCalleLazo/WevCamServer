using WebCamServer.Models.RedSocial;

namespace WebCamServer.Repositories.Interfaces
{
  public interface ICommentRepository
  {
    Task<List<Comment>> GetAll();
    Task<Comment> GetById(string id);
    Task Create(Comment newEntity);
    Task Update(string id, Comment updatedEntity);
    Task Delete(string id);
  }
}