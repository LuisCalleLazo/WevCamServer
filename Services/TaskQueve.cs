using System.Collections.Concurrent;
using WebCamServer.Dtos;

namespace WebCamServer.Services
{
  public class TaskQueue
  {
    // Cola para almacenar personas desaparecidas en espera de análisis
    private ConcurrentQueue<MissingPersonTask> _queue = new ConcurrentQueue<MissingPersonTask>();

    public void Enqueue(MissingPersonTask task)
    {
      _queue.Enqueue(task);
    }

    public bool TryDequeue(out MissingPersonTask task)
    {
      return _queue.TryDequeue(out task);
    }

    public bool IsEmpty => _queue.IsEmpty;
  }
}