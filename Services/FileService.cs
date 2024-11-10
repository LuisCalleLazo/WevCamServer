using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class FileService : IFileService
  {

    public FileService()
    {

    }

    public async Task UploadLocalFile(MissingToSaveDto save)
    {
      var path = Path.Combine(
        Directory.GetCurrentDirectory(), 
        ConstantsValueSystem.NameFolderMissigns(),
        $"{save.UserId}/{save.MissingId}/{save.Type}", 
        save.NameFile
      );

      Directory.CreateDirectory(Path.GetDirectoryName(path));

      try
      {
        // Intenta guardar el archivo sin sobrescribir si ya existe
        using (var stream = new FileStream(path, FileMode.CreateNew))
        {
          await save.File.CopyToAsync(stream);
        }
      }
      catch (IOException)
      {
        // Manejo en caso de que el archivo ya exista
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
  }
}