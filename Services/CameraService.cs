using System.Net.WebSockets;
using WebCamServer.Services.Interfaces;
using SixLabors.ImageSharp;
using System.Collections.Concurrent;

namespace WebCamServer.Services
{
  public class CameraService : ICameraService
  {

    private ConcurrentBag<WebSocket> _viewers = new ConcurrentBag<WebSocket>();

    public CameraService()
    {

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
      var buffer = new byte[1024 * 4];
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
                string directoryPath = Directory.GetCurrentDirectory() + @"/Video";
                Directory.CreateDirectory(directoryPath);

                string fileName = directoryPath + $"/video_{DateTime.Now.ToString()}.jpg";

                using (Image image = Image.Load(new MemoryStream(imageBytes)))
                {
                  Console.WriteLine("Image Write");
                  image.SaveAsJpeg(fileName); 
                }

                // await SendImageToViewers(_lastImageBytes);
              }
            }
          }
        }
      }
    }



    public async Task WatchCamera(WebSocket webSocket)
    {
      _viewers.Add(webSocket);
      Console.WriteLine("Viewer count: " + _viewers.Count);

      while (webSocket.State == WebSocketState.Open)
      {
        await Task.Delay(1000);
      }
      
      // Eliminar el cliente cuando se desconecte
      Console.WriteLine("Viewer disconnected. Removing from list.");
      _viewers = new ConcurrentBag<WebSocket>(_viewers.Except(new[] { webSocket }));
      Console.WriteLine("Viewer count after removal: " + _viewers.Count());
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
  }
}