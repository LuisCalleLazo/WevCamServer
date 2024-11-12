using System.Collections.Concurrent;
using WebCamServer.Dtos;

namespace WebCamServer.Services
{
  public class TaskNewQueue
  {
    private ConcurrentQueue<MissingPersonTask> _queue = new ConcurrentQueue<MissingPersonTask>();

    public void Enqueue(MissingPersonTask task)
    {
      _queue.Enqueue(task);
    }

    public bool TryDequeue(out MissingPersonTask task) => _queue.TryDequeue(out task);

    public bool IsEmpty => _queue.IsEmpty;
  }

  public class TaskOldQueue
  {
    private ConcurrentQueue<MissingPersonTask> _queue = new ConcurrentQueue<MissingPersonTask>();

    public void Enqueue(MissingPersonTask task)
    {
      _queue.Enqueue(task);
    }
    public bool TryDequeue(out MissingPersonTask task) => _queue.TryDequeue(out task);
    
    public bool IsEmpty => _queue.IsEmpty;
  }
}