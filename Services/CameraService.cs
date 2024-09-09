using System.Net.WebSockets;
using WebCamServer.Services.Interfaces;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Formats.Jpeg;

namespace WebCamServer.Services
{
  public class CameraService : ICameraService
  {

    private byte[] _lastImageBytes; // última imagen recibida
    private List<WebSocket> _viewers = new List<WebSocket>(); // clientes conectados
    public CameraService()
    {

    }

    public async Task Esp32CamConnection(WebSocket webSocket)
    {
      while (webSocket.State == WebSocketState.Open)
        {
          try
          {
            var buffer = new byte[1024 * 4];
            WebSocketReceiveResult result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
            if (result.MessageType == WebSocketMessageType.Close)
            {
              break;
            }
            else if (result.MessageType == WebSocketMessageType.Binary)
            {
              byte[] imageBytes = new byte[result.Count];
              Array.Copy(buffer, 0, imageBytes, 0, result.Count);
              Console.WriteLine($"Received image from ESP32: {result.Count} bytes.");

              if (IsValidImage(imageBytes))
              {
                using (MemoryStream ms = new MemoryStream(imageBytes))
                {
                  using (Image image = Image.Load(ms))
                  {
                    using (MemoryStream msTransmitir = new MemoryStream())
                    {
                      image.SaveAsJpeg(msTransmitir);
                      _lastImageBytes = msTransmitir.ToArray(); 
                    }
                  }
                }

                await SendImageToViewers(_lastImageBytes);
              }
            }
          }
          catch (Exception ex)
          {
            Console.WriteLine($"Error: {ex.Message}");
          }
        }
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

      // Remover los viewers con conexiones cerradas
      foreach (var socket in closedSockets)
      {
        _viewers.Remove(socket);
      }
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
    
    public async Task WatchCamera(WebSocket webSocket)
    {
      _viewers.Add(webSocket);

      if (_lastImageBytes != null && webSocket.State == WebSocketState.Open)
      {

        await webSocket.SendAsync(
          new ArraySegment<byte>(_lastImageBytes), 
          WebSocketMessageType.Binary, 
          true, 
          CancellationToken.None
        );

        Console.WriteLine("Sent to New Client");
      }

      while (webSocket.State == WebSocketState.Open)
      {
        await Task.Delay(1000);
      }

      // Remover el cliente cuando se desconecte
      _viewers.Remove(webSocket);
    }
  }
}