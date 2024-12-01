using System.Net.WebSockets;
using WebCamServer.Services.Interfaces;
using SixLabors.ImageSharp;
using System.Collections.Concurrent;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Dtos;
using WebCamServer.Models;
using AutoMapper;

namespace WebCamServer.Services
{
  public class CameraService : ICameraService
  {

    private ConcurrentBag<WebSocket> _viewers = new ConcurrentBag<WebSocket>();
    private readonly ICameraRepository _repo;
    private readonly IMapper _mapper;
    private readonly MqttBrokerService _mqttBrokerService;

    public CameraService(ICameraRepository repo, IMapper mapper)
    {
      _repo = repo;
      _mapper = mapper;
    }

    private async Task SendImageToViewers(byte[] imageBytes)
    {
      Console.WriteLine("Viewer count: " + _viewers.Count);
      List<WebSocket> closedSockets = new List<WebSocket>();

      foreach (var viewer in _viewers)
      {
        if (viewer.State == WebSocketState.Open)
        {
          try
          {
            await viewer.SendAsync(new ArraySegment<byte>(imageBytes), WebSocketMessageType.Binary, true, CancellationToken.None);
            Console.WriteLine("Image sent to viewer.");
          }
          catch (Exception ex)
          {
            Console.WriteLine($"Error sending to viewer: {ex.Message}");
            closedSockets.Add(viewer);
          }
        }
        else
        {
          closedSockets.Add(viewer);
        }
      }

      foreach (var socket in closedSockets)
      {
        _viewers = new ConcurrentBag<WebSocket>(_viewers.Except(new[] { socket }));
        Console.WriteLine("Viewer disconnected and removed.");
      }

      Console.WriteLine("Viewer count after cleanup: " + _viewers.Count());
    }

    private bool IsValidImage(byte[] imageBytes)
    {
      try
      {
        using (MemoryStream ms = new MemoryStream(imageBytes))
        {
          using (Image image = Image.Load(ms))
          {
            return true;
          }
        }
      }
      catch (Exception)
      {
        return false;
      }
    }
    
    public async Task Esp32CamConnection(WebSocket webSocket)
    {
      var buffer = new byte[1024 * 8];
      using (var ms = new MemoryStream())
      {
        while (webSocket.State == WebSocketState.Open)
        {
          WebSocketReceiveResult result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);

          if (result.MessageType == WebSocketMessageType.Close)
          {
            break;
          }
          else if (result.MessageType == WebSocketMessageType.Binary)
          {
            ms.Write(buffer, 0, result.Count);
            if (result.EndOfMessage)
            {
              byte[] imageBytes = ms.ToArray();
              ms.SetLength(0);

              if (IsValidImage(imageBytes))
              {
                Console.WriteLine("Image Valid");

                // Guardar la imagen en una carpeta
                string directoryPath = Directory.GetCurrentDirectory() + @"/Video/Video_" + DateTime.Now.ToString("yyyy-MM-dd");
                if (!Directory.Exists(directoryPath)) Directory.CreateDirectory(directoryPath);

                string dateName = DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss");
                string fileName = directoryPath + $"/video_{dateName}.jpg";

                using (Image image = Image.Load(new MemoryStream(imageBytes)))
                {
                  image.SaveAsJpeg(fileName); 
                  Console.WriteLine("Image Write");
                }

                await _mqttBrokerService.PublishMessageAsync("esp32cam/images", $"Imagen guardada: {fileName}");
              }
            }
          }
        }
      }
    }



    public async Task WatchCamera(WebSocket webSocket)
    {
      // Ruta de la carpeta que contiene las subcarpetas de video
      string videoFolderPath = Directory.GetCurrentDirectory() + @"/Video";
      var videoFolders = Directory.GetDirectories(videoFolderPath);

      foreach (var folder in videoFolders)
      {
          var images = Directory.GetFiles(folder, "*.jpg").OrderBy(f => f).ToList(); // Cambia la extensión según sea necesario
          foreach (var imagePath in images)
          {
              // Verificar si el WebSocket sigue abierto
              if (webSocket.State != WebSocketState.Open)
                  break;

              // Leer la imagen y convertirla a un arreglo de bytes
              byte[] imageBytes = await File.ReadAllBytesAsync(imagePath);
              
              // Enviar la imagen a través del WebSocket
              await webSocket.SendAsync(new ArraySegment<byte>(imageBytes), WebSocketMessageType.Binary, true, CancellationToken.None);
              
              // Esperar 1 segundo antes de enviar la siguiente imagen
              await Task.Delay(1000);
          }
      }
    }

    public async Task CloseAllConnections()
    {
      foreach (var viewer in _viewers)
      {
        if (viewer.State == WebSocketState.Open)
        {
          await viewer.CloseAsync(WebSocketCloseStatus.NormalClosure, "Server is shutting down", CancellationToken.None);
        }
      }
    }

    public async Task<CameraDetailDto> Create(CameraToCreateDto create)
    {
      var camera = new Camera();
      camera.Code = create.Code.ToString();
      camera.UbicationMap = create.UbicationMap;
      camera.CreateUserId = create.CreateUserId;
      camera.CreateAt = create.CreateAt;
      await _repo.Create(camera);
      return _mapper.Map<CameraDetailDto>(camera);
    }
  }
}