using WebCamServer.Dtos;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class AnalysisBackgroundService : BackgroundService
  {
    private readonly TaskOldQueue _taskOldQueue;
    private readonly TaskNewQueue _taskNewQueue;
    private readonly IDetectIAService _iaService;

    public AnalysisBackgroundService(
      TaskNewQueue taskNewQueue,
      TaskOldQueue taskOldQueue, 
      IDetectIAService iaService)
    {
      _taskNewQueue = taskNewQueue;
      _taskOldQueue = taskOldQueue;
      _iaService = iaService;
    }
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
      while (!stoppingToken.IsCancellationRequested)
      {
        if (_taskOldQueue.TryDequeue(out var task))
        {
          // Procesar la persona desaparecida
          await ProcessMissingPersonTask(task);
        }
        else
        {
          // Esperar un intervalo antes de volver a verificar la cola
          await Task.Delay(TimeSpan.FromSeconds(5), stoppingToken);
        }
      }
    }
    private async Task ProcessMissingPersonTask(MissingPersonTask task)
    {
      // Obtener las imágenes para analizar
      foreach (var imagePath in task.ImagePaths)
      {
        // Generar el embedding de la imagen nueva
        var embedding = await _iaService.GenerateEmbeddingAsync(imagePath);

        // Comparar el embedding con los de la persona desaparecida
        if (_iaService.CompareEmbeddings(embedding, task.ReferenceEmbeddings))
        {
          // Si hay coincidencia, notificar y marcar como encontrada
          // task.MarkAsFound();
          break;
        }
      }
    }
    
  }
}