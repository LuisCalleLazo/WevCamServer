using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Services.Interfaces;
using System.IO.Compression;
using WebCamServer.Models;
using System.Diagnostics;
using System.Globalization;

namespace WebCamServer.Services
{
  public class FileService : IFileService
  {
    public async Task UploadLocalFile(MissingToSaveDto save, string path_file)
    {
      var path = Path.Combine(path_file, save.NameFile);
      Directory.CreateDirectory(Path.GetDirectoryName(path));
      try
      {
        using (var stream = new FileStream(path, FileMode.CreateNew))
        {
          await save.File.CopyToAsync(stream);
        }
      }
      catch (IOException)
      {
        Console.WriteLine("El archivo ya existe. Cambie el nombre o maneje el conflicto según sea necesario.");
      }
    }

    public async Task<List<FileContentResult>> GetFilesOfFolder(string folder)
    {
      var fileResults = new List<FileContentResult>();
      
      // Obtener los archivos de imagen en formatos .jpg, .jpeg y .png
      var imageFiles = Directory.GetFiles(folder, "*.*")
        .Where(file => file.EndsWith(".jpg", StringComparison.OrdinalIgnoreCase) ||
                      file.EndsWith(".jpeg", StringComparison.OrdinalIgnoreCase) ||
                      file.EndsWith(".png", StringComparison.OrdinalIgnoreCase));

      foreach (var filePath in imageFiles)
      {
        var fileBytes = await System.IO.File.ReadAllBytesAsync(filePath);

        // Determinar el ContentType según la extensión del archivo
        string contentType = Path.GetExtension(filePath).ToLower() switch
        {
          ".jpg" => "image/jpeg",
          ".jpeg" => "image/jpeg",
          ".png" => "image/png",
          _ => "application/octet-stream" // Tipo de contenido predeterminado
        };

        var fileResult = new FileContentResult(fileBytes, contentType)
        {
          FileDownloadName = Path.GetFileName(filePath)
        };

        fileResults.Add(fileResult);
      }
      return fileResults;
    } 

    public async Task<byte[]> GetZipOfFilesOfFolder(string folder)
    {
      try
      {
        using (var memoryStream = new MemoryStream())
        {
          using (var archive = new ZipArchive(memoryStream, ZipArchiveMode.Create, true))
          {
            var files = Directory.GetFiles(folder);

            foreach (var filePath in files)
            {
              var fileName = Path.GetFileName(filePath);
              var zipEntry = archive.CreateEntry(fileName, CompressionLevel.Fastest);

              using (var entryStream = zipEntry.Open())
              using (var fileStream = File.OpenRead(filePath))
              {
                // Copiar el contenido del archivo en la entrada ZIP
                await fileStream.CopyToAsync(entryStream);
              }
            }
          }

          // Reiniciar la posición del memoryStream para que se lea desde el inicio
          memoryStream.Position = 0;
          return memoryStream.ToArray();
        }
      }
      catch(Exception ex)
      {
        Console.WriteLine(ex.Message);
        return null;
      }
    }

    public List<string> GetImagesOfFound(FoundVideo foundVideo)
    {
      string basePath = Path.Combine(Directory.GetCurrentDirectory(), "Video");

      // Carga las carpetas que coincidan con la fecha
      string targetFolder = Path.Combine(basePath, $"Video_{foundVideo.Date:yyyy-MM-dd}");
      if (!Directory.Exists(targetFolder))
      {
        Console.WriteLine("La carpeta para la fecha especificada no existe.");
        return [];
      }

      // Filtrar imágenes dentro del rango
      var images = Directory.GetFiles(targetFolder, "*.jpg")
        .Where(file =>
        {
          string fileName = Path.GetFileNameWithoutExtension(file);
          string timePart = fileName.Split('_').Last();
          if (TimeOnly.TryParseExact
            (timePart, 
            "HH-mm-ss", 
            CultureInfo.InvariantCulture, 
            DateTimeStyles.None, 
            out TimeOnly imageTime
            ))
          {
            return imageTime >= foundVideo.InitVideo && imageTime <= foundVideo.EndVideo;
          }
          return false;
        })
        .OrderBy(f => f)
        .ToList();

      return images;
    }


    
    public async Task<byte[]> GetZipOfFilesOfListFiles(List<string> files)
    {
      try
      {
        using (var memoryStream = new MemoryStream())
        {
          using (var archive = new ZipArchive(memoryStream, ZipArchiveMode.Create, true))
          {
            foreach (var filePath in files)
            {
              var fileName = Path.GetFileName(filePath);
              var zipEntry = archive.CreateEntry(fileName, CompressionLevel.Fastest);

              using (var entryStream = zipEntry.Open())
              using (var fileStream = File.OpenRead(filePath))
              {
                // Copiar el contenido del archivo en la entrada ZIP
                await fileStream.CopyToAsync(entryStream);
              }
            }
          }

          // Reiniciar la posición del memoryStream para que se lea desde el inicio
          memoryStream.Position = 0;
          return memoryStream.ToArray();
        }
      }
      catch(Exception ex)
      {
        Console.WriteLine(ex.Message);
        return null;
      }
    }


    public List<string> GetImagesOfRange(DateOnly date, TimeOnly init, TimeOnly end)
    {
      string basePath = Path.Combine(Directory.GetCurrentDirectory(), "Video");

      // Carga las carpetas que coincidan con la fecha
      string targetFolder = Path.Combine(basePath, $"Video_{date:yyyy-MM-dd}");
      if (!Directory.Exists(targetFolder))
      {
        Console.WriteLine("La carpeta para la fecha especificada no existe.");
        return [];
      }

      // Filtrar imágenes dentro del rango
      var images = Directory.GetFiles(targetFolder, "*.jpg")
        .Where(file =>
        {
          string fileName = Path.GetFileNameWithoutExtension(file);
          string timePart = fileName.Split('_').Last();
          if (TimeOnly.TryParseExact
            (timePart, 
            "HH-mm-ss", 
            CultureInfo.InvariantCulture, 
            DateTimeStyles.None, 
            out TimeOnly imageTime
            ))
          {
            return imageTime >= init && imageTime <= end;
          }
          return false;
        })
        .OrderBy(f => f)
        .ToList();

      return images;
    }


  }
}