using WebCamServer.Dtos;
using WebCamServer.Services.Interfaces;
using WebCamServer.Helpers;

namespace WebCamServer.Services
{
  public class AnalysisBackgroundService : BackgroundService
  {
    private readonly TaskOldQueue _taskOldQueue;
    private readonly TaskNewQueue _taskNewQueue;
    private readonly IServiceScopeFactory _scopeFactory;

    public AnalysisBackgroundService(
      TaskNewQueue taskNewQueue,
      TaskOldQueue taskOldQueue,
      IServiceScopeFactory scopeFactory)
    {
      _taskNewQueue = taskNewQueue;
      _taskOldQueue = taskOldQueue;
      _scopeFactory = scopeFactory;
    }
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
      var tasks = new List<Task>();

      while (!stoppingToken.IsCancellationRequested)
      {
        if (_taskOldQueue.TryDequeue(out var task))
        {
          // Inicia el procesamiento de las imágenes de esta persona en paralelo
          tasks.Add(ProcessMissingPersonTask(task)); 
        }
        
        if (_taskNewQueue.TryDequeue(out var taskNew))
        {
          tasks.Add(ProcessMissingPersonTask(taskNew));
        }

        // Esperar un intervalo si no hay tareas para procesar
        if (tasks.Count > 0)
        {
          await Task.WhenAll(tasks); // Ejecuta todas las tareas en paralelo
          tasks.Clear(); // Limpia la lista para nuevas tareas
        }
        else
        {
          await Task.Delay(TimeSpan.FromSeconds(5), stoppingToken); // Espera antes de volver a intentar
        }
      }
    }

    private async Task ProcessMissingPersonTask(MissingPersonTask task)
    {
      using (var scope = _scopeFactory.CreateScope())
      {
        var iaService = scope.ServiceProvider.GetRequiredService<IDetectIAService>();

        if (await iaService.PredictFace("Imagen a analizar.jpg", task.PathModel) == ResultPredictionType.Found)
        {
          task.MarkAsFound();
        }
      }
    }
    
  }
}